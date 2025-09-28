// DoctorListController.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/Api.dart';

class DoctorListController extends GetxController {
  var doctors = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;

  var page = 1.obs;
  var totalPages = 1.obs;
  var hasMore = true.obs;

  final Api _api = Api();
  var token = "".obs;

  Future<void> fetchDoctors({String? specialization, int page = 1}) async {
    if (token.value.isEmpty) return;

    try {
      if (page == 1) {
        isLoading.value = true;
      } else {
        isMoreLoading.value = true;
      }

      final response = await _api.getOnlineDoctors(
        specialization: specialization,
        page: page,
        token: token.value,
      );

      print("🔍 Doctors Page $page Response: $response");

      if (response.containsKey("data")) {
        final newDoctors = List<Map<String, dynamic>>.from(response["data"]);

        if (page == 1) {
          doctors.assignAll(newDoctors);
        } else {
          doctors.addAll(newDoctors);
        }

        // update pagination info
        this.page.value = response["page"] ?? 1;
        totalPages.value = response["total_pages"] ?? 1;
        hasMore.value = this.page.value < totalPages.value;
      }
    } catch (e) {
      print("❌ fetchDoctors Error: $e");
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  Future<void> loadNextPage({String? specialization}) async {
    if (hasMore.value && !isMoreLoading.value) {
      await fetchDoctors(
        specialization: specialization,
        page: page.value + 1,
      );
    }
  }

  Future<void> _loadTokenAndFetch() async {
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString("token") ?? "";

    if (token.value.isNotEmpty) {
      fetchDoctors(page: 1);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadTokenAndFetch();
  }
}
