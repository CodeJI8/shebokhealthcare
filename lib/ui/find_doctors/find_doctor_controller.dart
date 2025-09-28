import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/Api.dart';

class FindDoctorController extends GetxController {
  final Api api = Api();

  // 🔹 Location / District
  var location = "".obs; // manual fallback district
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var selectedDivision = "".obs;
  var selectedDistrict = "".obs;

  // 🔹 Pagination
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  // 🔹 Data
  var results = <Map<String, dynamic>>[].obs;

  // 🔹 State
  var isLoading = false.obs;
  var isLocationAllowed = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Request location permission every time the page opens
    _checkLocationPermission();
  }

  /// 🔹 Ask for location permission
  Future<void> _checkLocationPermission() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      isLocationAllowed.value = true;
      await _getCurrentLocation();
    } else {
      isLocationAllowed.value = false;
      Get.snackbar(
        "Location Permission Denied",
        "Please enable location permission in settings to access this feature.",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        mainButton: TextButton(
          onPressed: () => openAppSettings(),
          child: const Text("Go to Settings"),
        ),
      );
    }
  }

  /// 🔹 Get current lat/long if location is allowed
  Future<void> _getCurrentLocation() async {
    try {
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude.value = pos.latitude;
      longitude.value = pos.longitude;

      print("📍 Got location: ${latitude.value}, ${longitude.value}");

      // Load first page
      fetchDoctors(page: 1, limit: 10, isLoadMore: false);
    } catch (e) {
      print("❌ Location error: $e");
      Get.snackbar(
        "Location Error",
        "Failed to fetch location. Please ensure GPS is enabled.",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    }
  }

  /// 🔹 Fetch doctors from API (with pagination)
  Future<void> fetchDoctors({
    int page = 1,
    int limit = 10,
    bool isLoadMore = false,
  }) async {
    if (isLoading.value) return; // prevent duplicate calls
    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        Get.snackbar("Error", "You must login first");
        return;
      }

      // Build query params
      Map<String, dynamic> params = {
        "page": page,
        "limit": limit,
      };

      if (isLocationAllowed.value) {
        params["latitude"] = latitude.value;
        params["longitude"] = longitude.value;
      } else {
        params["district"] = location.value.toLowerCase().trim();
      }

      // 🔹 Call API
      final result = await api.findDoctors(
        district: params["district"],
        page: params["page"],
        limit: params["limit"],
        token: token,
        lat: params["latitude"],
        long: params["longitude"],
      );

      print("📡 Page $page Find Doctors Response: $result");

      if (result["status"] == "success" && result["data"] != null) {
        final List<Map<String, dynamic>> newData =
        List<Map<String, dynamic>>.from(result["data"]);

        if (isLoadMore) {
          results.addAll(newData); // append
        } else {
          results.value = newData; // replace
        }

        // Update pagination info
        currentPage.value = result["current_page"] ?? page;
        totalPages.value = result["total_pages"] ?? 1;
      } else {
        Get.snackbar("Error", result["message"] ?? "Failed to load doctors");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      print("❌ fetchDoctors error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔹 Load next page if available
  Future<void> loadMoreDoctors() async {
    if (currentPage.value < totalPages.value && !isLoading.value) {
      await fetchDoctors(
        page: currentPage.value + 1,
        limit: 10,
        isLoadMore: true,
      );
    }
  }
}
