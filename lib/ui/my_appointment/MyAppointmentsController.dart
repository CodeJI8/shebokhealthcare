// my_appointments_controller.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/Api.dart';

class MyAppointmentsController extends GetxController {
  var appointments = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var token = "".obs;

  final Api _api = Api();

  Future<void> fetchAppointments() async {
    try {
      isLoading.value = true;

      if (token.value.isEmpty) {
        final prefs = await SharedPreferences.getInstance();
        token.value = prefs.getString("token") ?? "";
      }

      if (token.value.isEmpty) {
        Get.snackbar("Error", "No token found. Please login again.");
        return;
      }

      final response = await _api.getUserAppointments(token: token.value);

      if (response["status"] == "success") {
        appointments.assignAll(List<Map<String, dynamic>>.from(response["data"]));
      } else {
        Get.snackbar("Error", "Failed to load appointments");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAppointments();
  }
}
