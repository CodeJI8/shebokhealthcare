import 'package:get/get.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var emailOrPhone = ''.obs;
  var password = ''.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    if (emailOrPhone.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields");
      return;
    }

    // API call or auth logic here
    Get.snackbar("Success", "Logged in successfully");
  }
}
