import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shebokhealthcare/ui/service/Api.dart';

class ThalassemiaRegisterController extends GetxController {
  final Api api = Api();

  var bloodReport = Rx<File?>(null);
  var prescription = Rx<File?>(null);
  var showNumber = false.obs;
  var selectedBloodGroup = "".obs;

  var isLoading = false.obs;

  // 👉 Only enable "Next" when blood group selected AND show number is ticked
  bool get canProceed =>
      selectedBloodGroup.isNotEmpty && showNumber.value;

  void toggleShowNumber(bool? value) {
    showNumber.value = value ?? false;
  }

  Future<void> submit() async {
    if (!canProceed) {
      Get.snackbar("Error", "Please select blood group and allow show number");
      return;
    }

    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        Get.snackbar("Error", "You must login first");
        return;
      }

      final response = await api.joinThalassemiaClub(
        bloodReportPath: bloodReport.value?.path,   // optional
        prescriptionPath: prescription.value?.path, // optional
        showNumber: showNumber.value ? 1 : 0,       // convert bool → int
        bloodGroup: selectedBloodGroup.value,
        token: token,
      );

      if (response["status"] == "success") {
        Get.snackbar("Success", "You have joined the Thalassemia Club!");
        Get.back(); // navigate back after success
      } else {
        Get.snackbar("Error", response["message"] ?? "Something went wrong");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
