import 'package:get/get.dart';

class RequestedPostController extends GetxController {
  var title = "A Life Is In Danger — We Need Your Help!".obs;
  var hospital = "Norjahan Hospital PVT. LTD".obs;
  var name = "Elina Kor".obs;
  var disease = "Thalassemia".obs;
  var bloodGroup = "O+".obs;
  var contactNumber = "014 744 44437".obs;
  var contactName = "John Doe".obs;
  var neededBy = "[Time/Date, If Urgent]".obs;

  var relatedRequests = [
    {
      "title": "Norjahan Hospital PVT. LTD",
      "name": "Elina Kor",
      "disease": "Thalassemia",
      "bloodGroup": "O+",
      "status": "Details"
    },
    {
      "title": "Norjahan Hospital PVT. LTD",
      "name": "Elina Kor",
      "disease": "Thalassemia",
      "bloodGroup": "O+",
      "status": "Details"
    },
    {
      "title": "Norjahan Hospital PVT. LTD",
      "name": "Elina Kor",
      "disease": "Thalassemia",
      "bloodGroup": "O+",
      "status": "Details"
    },
  ].obs;

  void callNow() {
    print("Calling $contactNumber...");
    // Implement phone dialer logic using url_launcher
  }
}
