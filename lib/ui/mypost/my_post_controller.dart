import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/Api.dart';

class Post {
  final String id;
  final String hospitalName;
  final String patientName;
  final String disease;
  final String bloodGroup;
  final String title;
  final String? donorName; // optional donor info
  final bool isUpdated; // ✅ new

  Post({
    required this.hospitalName,
    required this.patientName,
    required this.disease,
    required this.bloodGroup,
    required this.title,
    this.donorName,
    required this.id,
    this.isUpdated = false,
  });

  // 🔹 Add copyWith
  Post copyWith({
    String? hospitalName,
    String? patientName,
    String? disease,
    String? bloodGroup,
    String? donorName,
    String? title,
    String? id,
    bool? isUpdated,
  }) {
    return Post(
      hospitalName: hospitalName ?? this.hospitalName,
      title: title ?? this.title,
      id: id ?? this.id,
      patientName: patientName ?? this.patientName,
      disease: disease ?? this.disease,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      donorName: donorName ?? this.donorName,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }

  // ✅ Factory method to build Post from API response
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      hospitalName: json["hospital"]?.toString() ?? "Unknown Hospital",
      title: json["title"]?.toString() ?? "reload",
      patientName: json["pat_name"]?.toString() ?? "Unknown",
      disease: json["disease"]?.toString() ?? "N/A",
      bloodGroup: json["blood_group"]?.toString() ?? "N/A",
      donorName: json["donor_name"]?.toString(),
      id: json["id"]!.toString(),
    );
  }
}

class MyPostController extends GetxController {
  final Api api = Api();

  var posts = <Post>[].obs;
  var isLoading = false.obs;
  var isAddingDonor = false.obs; // ✅ new
  var selectedUser = Rxn<Map<String, dynamic>>();  // Selected donor
  var searchResults = <Map<String, dynamic>>[].obs; // Search results for users
  final donorName = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchMyPosts();
  }

  // 🔹 Fetch My Posts from API
  Future<void> fetchMyPosts() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        Get.snackbar("Error", "You must login first");
        return;
      }

      final result = await api.getMyPosts(token: token);
      print("📡 Get My Posts API Response: $result");

      if (result["status"] == "success" && result["data"] != null) {
        posts.value = (result["data"] as List).map((e) => Post.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", result["message"] ?? "Failed to load posts");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // 🔹 Search for users by name
  void searchDonors(String keyword) async {
    if (keyword.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token != null) {
      final result = await searchUsers(keyword, token);

      searchResults.value = result;
    }
  }

  // 🔹 Fetch users for search
  Future<List<Map<String, dynamic>>> searchUsers(String keyword, String token) async {
    final result = await api.searchUsers(keyword: keyword, token: token);

    print("📡 Searched user $result");

    if (result["status"] == "success") {
      final List data = result["data"] ?? [];
      return data.map((e) {
        return {
          "id": e["id"]?.toString() ?? "",
          "name": e["name"]?.toString() ?? "Unknown",
          "phone": e["phone"]?.toString() ?? "",
        };
      }).toList();
    } else {
      Get.snackbar("Error", result["message"] ?? "User search failed");
      return [];
    }
  }

  // 🔹 Select a user from search results
  void selectUser(Map<String, dynamic> user) {
    selectedUser.value = user;
    Get.snackbar("Selected", "You selected ${user['name']} as donor");
  }

  // 🔹 Add Donor to Post
  Future<bool> addDonorToPost({
    required int postIndex,
    required String token,
  }) async {
    if (selectedUser.value == null) {
      Get.snackbar("Error", "Please search and select a donor");
      return false;
    }

    isAddingDonor.value = true;
    try {
      final requestId = posts[postIndex].id;
      final result = await api.addDonorsToPosts(
        userId: selectedUser.value!["id"],
        requestId: requestId,
        token: token,
      );

      if (result["status"] == "success") {
        final updatedPost = posts[postIndex].copyWith(
          donorName: selectedUser.value!["name"],
          isUpdated: true,
        );
        updatePost(postIndex, updatedPost);

        Get.snackbar("Success", "Donor added successfully");
        return true; // ✅ success
      } else {
        Get.snackbar("Error", result["message"] ?? "Failed to add donor");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to add donor: $e");
      return false;
    } finally {
      isAddingDonor.value = false;
    }
  }

  // 🔹 Update post details
  void updatePost(int index, Post updatedPost) {
    if (index >= 0 && index < posts.length) {
      posts[index] = updatedPost.copyWith(isUpdated: true);
      posts.refresh();
      Get.snackbar("Updated", "Post updated successfully");
    } else {
      Get.snackbar("Error", "Invalid post index");
    }
  }

  // 🔹 Delete a post
  void deletePost(int index) {
    if (index >= 0 && index < posts.length) {
      posts.removeAt(index);
      Get.snackbar("Deleted", "Post deleted successfully");
    } else {
      Get.snackbar("Error", "Invalid post index");
    }
  }

  @override
  void onClose() {
    donorName.dispose();
    super.onClose();
  }
}
