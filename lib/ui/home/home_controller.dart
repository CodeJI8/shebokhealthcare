import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/Api.dart';

class HomeController extends GetxController {
  final Api api = Api();

  var campaignDate = "23/06/2025".obs;
  var bloodTypes = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"].obs;

  var requests = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  Future<void> fetchRequests({int page = 1, int limit = 10}) async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        Get.snackbar("Error", "You must login first");
        return;
      }

      final result = await api.getBloodRequests(
        page: page,
        limit: limit,
        token: token,
      );

      if (result["status"] == "success" && result["data"] != null) {
        requests.value = List<Map<String, dynamic>>.from(result["data"]);
      } else {
        Get.snackbar("Error", result["message"] ?? "Failed to load requests");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
