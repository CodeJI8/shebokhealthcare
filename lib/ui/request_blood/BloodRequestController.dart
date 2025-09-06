import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/Api.dart'; // ✅ import your Api service

class BloodRequestController extends GetxController {
  final Api api = Api();

  // Text controllers
  final requestTitleController = TextEditingController();
  final hospitalAddressController = TextEditingController();
  final patientNameController = TextEditingController();
  final diseaseController = TextEditingController();

  // Date (YYYY-MM-DD)
  var requestDate = ''.obs;

  // Blood group
  final selectedBloodGroup = ''.obs;
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

  // Location
  var useLocation = false.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var selectedDivision = ''.obs;
  var selectedDistrict = ''.obs;

  // Loading state
  var isLoading = false.obs;

  // Submit blood request
  Future<void> submitRequest() async {
    if (requestTitleController.text.isEmpty ||
        hospitalAddressController.text.isEmpty ||
        patientNameController.text.isEmpty ||
        diseaseController.text.isEmpty ||
        selectedBloodGroup.value.isEmpty ||
        requestDate.value.isEmpty) {
      Get.snackbar("Error", "Please fill all fields",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        Get.snackbar("Error", "You must login first",
            snackPosition: SnackPosition.BOTTOM);
        isLoading.value = false;
        return;
      }

      // ✅ Use Api service instead of http.post
      final result = await api.requestBlood(
        title: requestTitleController.text,
        disease: diseaseController.text,
        hospital: hospitalAddressController.text,
        bloodGroup: selectedBloodGroup.value,
        date: requestDate.value,
        patientName: patientNameController.text,
        latitude: useLocation.value ? latitude.value : null,
        longitude: useLocation.value ? longitude.value : null,
        district: !useLocation.value ? selectedDistrict.value : null,
        token: token,
      );

      if (result["status"] == "success") {
        Get.snackbar("Success", result["message"] ?? "Request posted",
            snackPosition: SnackPosition.BOTTOM);
        clearForm();
      } else {
        Get.snackbar("Error", result["message"] ?? "Failed to post",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    requestTitleController.clear();
    hospitalAddressController.clear();
    patientNameController.clear();
    diseaseController.clear();
    selectedBloodGroup.value = '';
    requestDate.value = '';
    latitude.value = 0.0;
    longitude.value = 0.0;
    selectedDivision.value = '';
    selectedDistrict.value = '';
    useLocation.value = false;
  }
}
