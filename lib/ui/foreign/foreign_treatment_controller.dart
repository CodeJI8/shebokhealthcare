import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForeignTreatmentController extends GetxController {
  final fullName = TextEditingController();
  final gender = TextEditingController();
  final address = TextEditingController();
  final disease = TextEditingController();
  final duration = TextEditingController();
  final email = TextEditingController();
  final consultancy = TextEditingController();
  final description = TextEditingController();

  void submitForm() {
    if (fullName.text.isEmpty || email.text.isEmpty) {
      Get.snackbar("Error", "Please fill in required fields (Name, Email)");
      return;
    }

    // For now just log / show snackbar
    Get.snackbar("Submitted", "Form submitted successfully");

    // Here you can call API to send data
  }

  @override
  void onClose() {
    fullName.dispose();
    gender.dispose();
    address.dispose();
    disease.dispose();
    duration.dispose();
    email.dispose();
    consultancy.dispose();
    description.dispose();
    super.onClose();
  }
}
