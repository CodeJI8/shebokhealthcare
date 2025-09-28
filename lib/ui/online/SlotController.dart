// slot_controller.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/Api.dart';

class SlotController extends GetxController {
  var slots = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var token = "".obs;

  final Api _api = Api();

  Future<void> getSlots(int doctorId, String date) async {
    if (token.value.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      token.value = prefs.getString("token") ?? "";
    }

    try {
      isLoading.value = true;

      final response = await _api.getAvailableSlots(
        doctorId: doctorId,
        date: date,
        token: token.value,
      );

      if (response["status"] == "success") {
        slots.assignAll(List<Map<String, dynamic>>.from(response["data"]));
      } else {
        Get.snackbar("Error", "No slots available");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> bookAppointment({
    required int slotId,
    required String date,
    required String name,
    required double age,
    String? notes,
  }) async {
    try {
      final response = await _api.bookAppointment(
        slotId: slotId,
        date: date,
        name: name,
        age: age,
        notes: notes,
        token: token.value,
      );

      if (response["status"] == "success") {
        Get.back(); // close slot picker
        Get.snackbar("✅ Success", response["message"] ?? "Appointment booked");
      } else {
        Get.snackbar("Error", response["message"] ?? "Booking failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
