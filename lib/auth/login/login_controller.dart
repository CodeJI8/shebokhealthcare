import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shebokhealthcare/ui/home/home.dart';
import '../../ui/service/Api.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var phone = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var isrememberme = false.obs;

  // 👇 Controllers to bind with TextFields
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    _loadSavedLogin();
  }

  Future<void> _loadSavedLogin() async {
    final prefs = await SharedPreferences.getInstance();

    phone.value = prefs.getString("phone") ?? "";
    password.value = prefs.getString("password") ?? "";
    isrememberme.value = prefs.getBool("rememberMe") ?? false;

    // 👇 Pre-fill input fields
    phoneController.text = phone.value;
    passwordController.text = password.value;

    // 👇 Auto-login if Remember Me was checked and token exists
    final token = prefs.getString("token");
    if (isrememberme.value && token != null && token.isNotEmpty) {
      // ✅ Navigate directly to Home
      Get.offAll(HomeScreen());
    }
  }


  void toggleRememberMe(bool? value) {
    isrememberme.value = value ?? false;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async {
    if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields");
      return;
    }

    try {
      isLoading.value = true;
      final result = await Api().userLogin(
        phone: phoneController.text,
        password: passwordController.text,
      );

      if (result["status"] == "success") {
        final user = result["user"];
        final token = user?['token'];

        Get.snackbar("Success", result["message"] ?? "Login successful");

        final prefs = await SharedPreferences.getInstance();

        // ✅ Always save token
        if (token != null) {
          await prefs.setString("token", token);
        }

        // ✅ Save login only if Remember Me is checked
        if (isrememberme.value) {
          await prefs.setString("phone", phoneController.text);
          await prefs.setString("password", passwordController.text);
          await prefs.setBool("rememberMe", true);
        } else {
          await prefs.remove("phone");
          await prefs.remove("password");
          await prefs.setBool("rememberMe", false);
        }

        // 👉 Navigate
        Get.offAll(HomeScreen());
      } else {
        Get.snackbar("Error", result["message"] ?? "Login failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
