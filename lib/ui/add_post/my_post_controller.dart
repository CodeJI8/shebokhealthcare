import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Post {
  final String hospitalName;
  final String patientName;
  final String disease;
  final String bloodGroup;
  final String? donorName; // optional donor info

  Post({
    required this.hospitalName,
    required this.patientName,
    required this.disease,
    required this.bloodGroup,
    this.donorName,
  });
}

class MyPostController extends GetxController {
  final hospitalName = TextEditingController();
  final patientName = TextEditingController();
  final disease = TextEditingController();
  final donorName = TextEditingController();

  var posts = <Post>[].obs;
  RxBool isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    // dummy posts
    posts.addAll([
      Post(
          hospitalName: "Norjahan Hospital PVT. LTD",
          patientName: "Elina Kor",
          disease: "Thalassemia",
          bloodGroup: "O+"),
      Post(
          hospitalName: "City Care Hospital",
          patientName: "Arman Hossain",
          disease: "Leukemia",
          bloodGroup: "A+"),
      Post(
          hospitalName: "Green Life Clinic",
          patientName: "Rima Akter",
          disease: "Thalassemia",
          bloodGroup: "B+"),
    ]);
  }

  void submitPost() async {
    if (hospitalName.text.isEmpty ||
        patientName.text.isEmpty ||
        disease.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    isSubmitting.value = true;

    await Future.delayed(Duration(seconds: 1));

    posts.add(Post(
      hospitalName: hospitalName.text,
      patientName: patientName.text,
      disease: disease.text,
      bloodGroup: "O+", // can make this dynamic later
    ));

    clearFields();
    isSubmitting.value = false;

    Get.snackbar("Success", "Post added successfully");
  }

  /// Show delete donor dialog
  void showDeleteDialog(int index) {
    donorName.clear();
    Get.defaultDialog(
      title: "Donated Person's Info",
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: donorName,
            decoration: InputDecoration(
              hintText: "Enter The Name",
              isDense: true, // reduces height
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[900],
              minimumSize: const Size(double.infinity, 40), // reduced height
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              if (donorName.text.trim().isEmpty) {
                Get.snackbar("Error", "Please enter donor name");
              } else {
                posts.removeAt(index);
                Get.back();
                Get.snackbar(
                  "Deleted",
                  "Post removed successfully by donor ${donorName.text}",
                );
              }
            },
            child: const Text("Next", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }


  void updatePost(int index, Post updatedPost) {
    posts[index] = updatedPost;
    posts.refresh();
    Get.snackbar("Updated", "Post updated successfully");
  }

  void cancelUpdate() {
    clearFields();
    Get.snackbar("Cancelled", "Update cancelled");
  }

  void clearFields() {
    hospitalName.clear();
    patientName.clear();
    disease.clear();
  }

  @override
  void onClose() {
    hospitalName.dispose();
    patientName.dispose();
    disease.dispose();
    donorName.dispose();
    super.onClose();
  }
}
