import 'package:get/get.dart';

class AreaFilterController extends GetxController {
  var location = "Sylhet".obs;

  // Example doctors/hospitals list
  var results = [
    {
      "name": "Arthur",
      "specialty": "Orthopedic",
      "hospital": "Mount Adora Hospital, Noyashorok, Sylhet",
      "rating": 5,
      "image": "https://i.pravatar.cc/100?img=1",
    },
    {
      "name": "Sylhet Imperial Hospital",
      "specialty": "",
      "hospital": "Bongobir, Naiorpul",
      "rating": 5,
      "image": "https://i.pravatar.cc/100?img=2",
    },
    {
      "name": "Arthur",
      "specialty": "Orthopedic",
      "hospital": "Mount Adora Hospital, Noyashorok, Sylhet",
      "rating": 5,
      "image": "https://i.pravatar.cc/100?img=3",
    },
  ].obs;
}
