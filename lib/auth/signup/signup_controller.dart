import 'package:get/get.dart';

import '../../ui/service/Api.dart';
import '../login/login_page.dart';

class SignupController extends GetxController {
  // State variables
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  // Form fields
  var fullName = ''.obs;
  var Phone = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var referralCode = ''.obs;

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Sign-up logic
  // ✅ Use service here instead of http.post
  Future<void> signup() async {
    if (fullName.value.isEmpty || Phone.value.isEmpty || password.value.isEmpty) {
      Get.snackbar("Error", "Please fill all required fields");
      return;
    }

    if (password.value != confirmPassword.value) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    try {
      final result = await Api().userReg(
        name: fullName.value,
        phone: Phone.value,
        password: password.value,
        refer: referralCode.value.isNotEmpty ? referralCode.value : null,
      );

      // 👇 Print results
      print("📦 API Response Map: $result");
      print("➡ Status: ${result['status']}");
      print("➡ Message: ${result['message']}");

      if (result["status"] == "success") {
        Get.snackbar("Success", result["message"] ?? "Signup successful");
        // Navigate if needed
        Get.offAll(LoginPage());
      } else {
        Get.snackbar("Error", result["message"] ?? "Signup failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}