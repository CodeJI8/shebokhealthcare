import 'package:get/get.dart';

class HomeController extends GetxController {
  var campaignDate = "23/06/2025".obs;

  var bloodTypes = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"].obs;

  var requests = [
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
      "bloodGroup": "O-",
      "status": "Success"
    }
  ].obs;
}
