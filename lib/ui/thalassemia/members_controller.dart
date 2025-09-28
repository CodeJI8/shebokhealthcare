import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shebokhealthcare/ui/service/Api.dart';
import 'package:shebokhealthcare/ui/thalassemia/register/thalassemia_register_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class Member {
  final String name;
  final String phone;
  final String bloodGroup;
  final String imageUrl;

  Member({
    required this.name,
    required this.phone,
    required this.bloodGroup,
    required this.imageUrl,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json["name"] ?? "Unknown",
      phone: json["phone"] ?? "N/A",
      bloodGroup: json["blood_group"] ?? "N/A",
      imageUrl: json["image"] ?? "https://via.placeholder.com/150",
    );
  }
}

class MembersController extends GetxController {
  final Api api = Api();

  var members = <Member>[].obs;
  var isLoading = false.obs;
  var page = 1.obs;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMembers(); // load first page automatically
  }

  Future<void> fetchMembers({bool loadMore = false}) async {
    if (isLoading.value) return;
    if (loadMore && !hasMore.value) return;

    try {
      isLoading.value = true;

      if (!loadMore) {
        page.value = 1;
        members.clear();
        hasMore.value = true;
      }

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        Get.snackbar("Error", "You must login first");
        return;
      }

      final response = await api.getThalassemiaPatients(
        page: page.value,
        limit: 10,
        token: token,
      );

      if (response["status"] == "success") {
        List data = response["data"] ?? [];

        final newMembers = data.map((m) => Member.fromJson(m)).toList().cast<Member>();

        if (newMembers.isEmpty) {
          hasMore.value = false;
        } else {
          members.addAll(newMembers);
          page.value++;
        }
      } else {
        Get.snackbar("Error", response["message"] ?? "Failed to load members");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Open the phone dialer
  void callMember(String phone) async {
    final Uri _phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunch(_phoneUri.toString())) {
      await launch(_phoneUri.toString());
    } else {
      Get.snackbar("Error", "Unable to make a call.");
    }
  }

  void joinNow() {
    Get.to(() => ThalassemiaRegisterScreen());
  }

  void registerNow() {
    Get.to(() => ThalassemiaRegisterScreen());
  }
}
