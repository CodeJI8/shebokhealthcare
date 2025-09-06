import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import '../../api.dart'; // adjust path if needed

class ProfileCreateController extends GetxController {
  // Profile fields
  var bloodGroup = ''.obs;
  var medicalInfo = ''.obs;
  var lastDonationDate = ''.obs;

  // Location handling
  var useLocation = false.obs; // true = GPS, false = manual
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var selectedDivision = ''.obs;
  var selectedDistrict = ''.obs;

  // Loader for Next button
  var isLoading = false.obs;

  /// 📍 Ask for permission + get current location
  Future<void> detectLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        Get.snackbar("Permission Denied",
            "Please enable location permission in settings.");
        useLocation.value = false;
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude.value = pos.latitude;
      longitude.value = pos.longitude;

      print("📍 Location: Lat=${latitude.value}, Lng=${longitude.value}");
    } catch (e) {
      print("❌ Location error: $e");
      Get.snackbar("Error", "Unable to get location: $e");
      useLocation.value = false;
    }
  }

  /// 🔹 Create Donor Profile
  Future<void> createProfile() async {
    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null || token.isEmpty) {
        print("❌ No token found, user not logged in");
        isLoading.value = false;
        return;
      }

      // If using GPS, make sure we have fresh coords
      if (useLocation.value) {
        await detectLocation();
      }

      final response = await Api().donorReg(
        bloodGroup: bloodGroup.value,
        lastDonationDate:
        lastDonationDate.value.isNotEmpty ? lastDonationDate.value : null,
        medicalInfo: medicalInfo.value.isNotEmpty ? medicalInfo.value : null,
        latitude: useLocation.value ? latitude.value : null,
        longitude: useLocation.value ? longitude.value : null,
        district: !useLocation.value ? selectedDistrict.value : null,
        token: token,
      );

      if (response["status"] == "success") {
        print("✅ Donor registered successfully: $response");
        Get.snackbar("Success", "Profile created successfully");
      } else {
        print("⚠️ Donor registration failed: $response");
        Get.snackbar("Error", response["message"] ?? "Registration failed");
      }
    } catch (e) {
      print("❌ API Error: $e");
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
