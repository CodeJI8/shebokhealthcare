import 'package:get/get.dart';

class RequestedPostController extends GetxController {
  var title = "".obs;
  var hospital = "".obs;
  var name = "".obs;
  var disease = "".obs;
  var bloodGroup = "".obs;
  var contactNumber = "".obs;
  var contactName = "".obs;
  var neededBy = "".obs;

  var relatedRequests = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();

    final data = Get.arguments; // 🔹 Receive passed data
    if (data != null) {
      title.value = data["title"] ?? "Untitled";
      hospital.value = data["hospital"] ?? "Unknown Hospital";
      name.value = data["pat_name"] ?? "Unknown";
      disease.value = data["disease"] ?? "Not specified";
      bloodGroup.value = data["blood_group"] ?? "-";
      contactNumber.value = data["contact_number"] ?? "N/A";
      contactName.value = data["contact_name"] ?? "N/A";
      neededBy.value = data["needed_by"] ?? "Not specified";
    }
  }
}
