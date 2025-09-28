import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ui/service/Api.dart';


class KycVerificationController extends GetxController {
  var documentPath = ''.obs;
  final Api api = Api();

  final ImagePicker picker = ImagePicker();

  // Pick a document (image only for now)
  Future<void> pickDocument() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      documentPath.value = picked.path;
    }
  }

  // Submit KYC document
  Future<void> submitKyc() async {
    if (documentPath.value.isEmpty) {
      Get.snackbar("Error", "Please upload a document first.");
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        Get.snackbar("Error", "User not logged in");
        return;
      }

      final result = await api.uploadKyc(
        filePath: documentPath.value,
        token: token,
      );

      if (result["status"] == "success") {
        Get.snackbar("Success", "KYC uploaded successfully");
        Get.back(); // go back to ProfileScreen
      } else {
        Get.snackbar("Error", result["message"] ?? "Upload failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
