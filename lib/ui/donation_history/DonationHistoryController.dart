import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/Api.dart';
import 'DonationHistory.dart';


class DonationHistoryController extends GetxController {
  var donations = <DonationHistory>[].obs;
  var isLoading = false.obs;

  final Api api = Api();

  @override
  void onInit() {
    super.onInit();
    fetchDonationHistory();
  }

  Future<void> fetchDonationHistory() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        Get.snackbar("Error", "User not logged in");
        return;
      }

      final result = await api.getDonationHistory(token: token);

      if (result["status"] == "success") {
        final List data = result["data"];
        donations.value =
            data.map((e) => DonationHistory.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", result["message"] ?? "Failed to load history");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
