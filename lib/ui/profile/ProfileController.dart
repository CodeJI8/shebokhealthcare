import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/kyc/KycVerificationPage.dart';
import '../service/Api.dart';


class ProfileController extends GetxController {
  var name = "".obs;
  var phone = "".obs;
  var referCode = "".obs;
  var profileImage = "".obs;
  var kycStatus = "".obs;

  final Api api = Api();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        Get.snackbar("Error", "User not logged in");
        return;
      }

      final result = await api.getProfile(token: token);

      if (result["status"] == "success") {
        final data = result["data"];

        name.value = data["name"] ?? "";
        phone.value = data["phone"] ?? "";
        referCode.value = data["refer_code"] ?? "";
        profileImage.value = data["pro_path"] ?? "";
        kycStatus.value = data["kyc_status"] ?? "";
      } else {
        Get.snackbar("Error", result["message"] ?? "Failed to load profile");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  // 👉 Navigate to KYC Page only if "not_applied"
  void goToKycPage() {
    if (kycStatus.value == "not_applied") {
      Get.to(() => KycVerificationPage());
    } else if (kycStatus.value == "pending") {
      Get.snackbar("Info", "Your KYC is under review.");
    } else if (kycStatus.value == "approved") {
      Get.snackbar("Info", "Your KYC is already approved.");
    }
  }

  // Upload new profile image
  Future<void> uploadProfileImage(String filePath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        Get.snackbar("Error", "User not logged in");
        return;
      }

      final result = await api.uploadProfile(filePath: filePath, token: token);

      if (result["status"] == "success") {
        profileImage.value = filePath;
        Get.snackbar("Success", "Profile image updated");
      } else {
        Get.snackbar("Error", result["message"] ?? "Upload failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed("/login");
  }
}
