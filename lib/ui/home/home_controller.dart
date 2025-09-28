import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/Api.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  final Api api = Api();

  var bloodTypes = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"].obs;
  var sliders = <Map<String, dynamic>>[].obs;
  var requests = <Map<String, dynamic>>[].obs;  // All requests
  var isLoading = false.obs;
  var isNearbyOn = false.obs; // To manage the nearby switch
  var selectedBloodType = "".obs;
  var currentPage = 1.obs; // Track current page for pagination
  var hasMoreData = true.obs; // To check if more data is available

  // For storing location data
  var currentLatitude = 0.0.obs;
  var currentLongitude = 0.0.obs;

// Getter to filter requests based on the selected blood type
  List<Map<String, dynamic>> get filteredRequests {
    if (selectedBloodType.value.isEmpty) {
      return requests;  // Return all requests if no blood type is selected
    } else {
      return requests
          .where((req) => req["blood_group"] == selectedBloodType.value)  // Filter by blood type
          .toList();
    }
  }


  @override
  void onInit() {
    super.onInit();
    fetchRequests(page: currentPage.value);  // Fetch all requests by default
    fetchSliders();
  }

  // Toggle blood type filter
  void selectBloodType(String type) {
    if (selectedBloodType.value == type) {
      selectedBloodType.value = ""; // Deselect
    } else {
      selectedBloodType.value = type;
    }
  }

  // Toggle Nearby feature
  void toggleNearby(bool isEnabled) async {
    if (isEnabled) {
      bool permissionGranted = await _requestLocationPermission();
      if (permissionGranted) {
        isNearbyOn.value = true;
        _getUserLocation();
        currentPage.value = 1;  // Reset to first page for nearby requests
        fetchRequests(isNearby: true, page: currentPage.value);  // Fetch nearby posts
      } else {
        isNearbyOn.value = false;
      }
    } else {
      isNearbyOn.value = false;
      currentPage.value = 1;  // Reset to page 1 when switching to all posts
      fetchRequests(page: currentPage.value);  // Fetch all posts
    }
  }

  // Request location permission
  Future<bool> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission == LocationPermission.whileInUse || permission == LocationPermission.always;
  }

  // Get current location
  Future<void> _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentLatitude.value = position.latitude;
    currentLongitude.value = position.longitude;
  }

  Future<void> fetchRequests({bool isNearby = false, required int page}) async {
    if (isLoading.value || !hasMoreData.value) return; // Prevent duplicate fetches

    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        Get.snackbar("Error", "You must login first");
        return;
      }

      // Clear previous requests when switching between 'Nearby' and 'All Posts'
      if (page == 1) {
        requests.clear();
        hasMoreData.value = true; // Reset for the new data fetch
      }

      // Fetch blood requests from API
      final result = await api.getBloodRequests(
        page: page, // Use the page passed to this method
        limit: 5,  // Set limit to 5 posts per page
        token: token,
        latitude: isNearby ? currentLatitude.value : null, // Pass location if nearby
        longitude: isNearby ? currentLongitude.value : null, // Pass location if nearby
      );

      if (result["status"] == "success" && result["data"] != null) {
        final newRequests = List<Map<String, dynamic>>.from(result["data"]);
        if (newRequests.isEmpty) {
          hasMoreData.value = false; // No more data available
        } else {
          requests.addAll(newRequests); // Append new requests to the existing list
          currentPage.value++; // Increment the page for the next fetch
        }
      } else {
        Get.snackbar("Error", result["message"] ?? "Failed to load requests");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch sliders
  Future<void> fetchSliders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null || token.isEmpty) {
        sliders.clear();
        return;
      }

      final result = await api.getSliders(token: token); // ✅ Pass token
      if (result["status"] == "success" && result["sliders"] != null) {
        sliders.value = List<Map<String, dynamic>>.from(result["sliders"]);
      } else {
        sliders.clear(); // Clear sliders if the data is not present
      }
    } catch (e) {
      sliders.clear(); // Clear sliders if an error occurs
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}
