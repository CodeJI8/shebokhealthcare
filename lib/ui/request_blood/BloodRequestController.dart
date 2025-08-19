import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BloodRequestController extends GetxController {
  // Text controllers for each field
  final requestTitleController = TextEditingController();
  final hospitalAddressController = TextEditingController();
  final patientNameController = TextEditingController();
  final diseaseController = TextEditingController();

  // Dropdown selected value
  final selectedBloodGroup = ''.obs;

  // Blood groups list
  final List<String> bloodGroups = [
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-",
  ];

  // Handle submit
  void submitRequest() {
    if (requestTitleController.text.isEmpty ||
        hospitalAddressController.text.isEmpty ||
        patientNameController.text.isEmpty ||
        diseaseController.text.isEmpty ||
        selectedBloodGroup.value.isEmpty) {
      Get.snackbar("Error", "Please fill all fields",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // TODO: Send data to backend
    print("Request Submitted:");
    print("Title: ${requestTitleController.text}");
    print("Hospital: ${hospitalAddressController.text}");
    print("Patient: ${patientNameController.text}");
    print("Disease: ${diseaseController.text}");
    print("Blood Group: ${selectedBloodGroup.value}");

    Get.snackbar("Success", "Blood request posted successfully!",
        snackPosition: SnackPosition.BOTTOM);
  }
}
