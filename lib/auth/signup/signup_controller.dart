import 'package:get/get.dart';

class SignupController extends GetxController {
  // State variables
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  // Form fields
  var fullName = ''.obs;
  var email = ''.obs;
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
  void signup() {
    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill in all required fields");
      return;
    }

    if (password.value != confirmPassword.value) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    // Here you can add API call logic
    Get.snackbar("Success", "Account created successfully!");
  }
}
