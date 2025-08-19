import 'package:get/get.dart';
import 'package:shebokhealthcare/ui/thalassemia/register/thalassemia_register_screen.dart';

class Member {
  final String name;
  final String phone;
  final String bloodGroup;
  final String imageUrl;

  Member({
    required this.name,
    required this.phone,
    required this.bloodGroup,
    required this.imageUrl,
  });
}

class MembersController extends GetxController {
  // Sample members data


  var members = <Member>[
    Member(
      name: "Arthur",
      phone: "016 4749 74383",
      bloodGroup: "O+",
      imageUrl: "https://randomuser.me/api/portraits/men/1.jpg",
    ),
    Member(
      name: "Arthur",
      phone: "016 4749 74383",
      bloodGroup: "O+",
      imageUrl: "https://randomuser.me/api/portraits/men/2.jpg",
    ),
    Member(
      name: "Arthur",
      phone: "016 4749 74383",
      bloodGroup: "O+",
      imageUrl: "https://randomuser.me/api/portraits/women/3.jpg",
    ),
    Member(
      name: "Arthur",
      phone: "016 4749 74383",
      bloodGroup: "O+",
      imageUrl: "https://randomuser.me/api/portraits/men/4.jpg",
    ),
    Member(
      name: "Arthur",
      phone: "016 4749 74383",
      bloodGroup: "O+",
      imageUrl: "https://randomuser.me/api/portraits/men/5.jpg",
    ),
    Member(
      name: "Arthur",
      phone: "016 4749 74383",
      bloodGroup: "O+",
      imageUrl: "https://randomuser.me/api/portraits/men/6.jpg",
    ),
    Member(
      name: "Arthur",
      phone: "016 4749 74383",
      bloodGroup: "O+",
      imageUrl: "https://randomuser.me/api/portraits/men/7.jpg",
    ),
  ].obs;

  void callMember(String phone) {
    // TODO: integrate with url_launcher to actually make phone calls
    print("Calling $phone...");
  }

  void joinNow() {
    Get.to(() => ThalassemiaRegisterScreen()); // 🚀 navigate
  }

  void registerNow() {
    Get.to(() => ThalassemiaRegisterScreen()); // 🚀 navigate
  }

}
