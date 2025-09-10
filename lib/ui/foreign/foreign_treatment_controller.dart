import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shebokhealthcare/ui/home/home.dart';
import '../../ui/service/Api.dart';

class ForeignTreatmentController extends GetxController {
  final email = TextEditingController();
  final disease = TextEditingController();
  final duration = TextEditingController(); // months (int)
  final description = TextEditingController(); // optional

  var isLoading = false.obs;

  Future<void> submitForm() async {
    if (email.text.isEmpty || disease.text.isEmpty || duration.text.isEmpty) {
      Get.snackbar("Error", "Please fill in required fields (Email, Disease, Duration)");
      return;
    }

    final int? durationInMonths = int.tryParse(duration.text);
    if (durationInMonths == null) {
      Get.snackbar("Error", "Duration must be a valid number (in months)");
      return;
    }

    try {
      isLoading.value = true;

      // ✅ Load token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "User not logged in. Please login first.");
        return;
      }

      final response = await Api().foreignTreatment(
        email: email.text,
        disease: disease.text,
        duration: durationInMonths,
        description: description.text.isNotEmpty ? description.text : null,
        token: token,
      );

      if (response["status"] == "success") {
        Get.snackbar("Success", "Foreign treatment request submitted");
        Get.to(HomeScreen()); // ✅ optional: close the form after success
      } else {
        Get.snackbar("Error", response["message"] ?? "Submission failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    email.dispose();
    disease.dispose();
    duration.dispose();
    description.dispose();
    super.onClose();
  }
}
