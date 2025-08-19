import 'package:get/get.dart';

class ProfileCreateController extends GetxController {
  var bloodGroup = ''.obs;
  var medicalInfo = ''.obs;
  var lastDonationDate = ''.obs;
  var location = ''.obs;

  void createProfile() {
    // Add API call or logic to save profile
    print("Profile Created:");
    print("Blood Group: ${bloodGroup.value}");
    print("Medical Info: ${medicalInfo.value}");
    print("Last Donation Date: ${lastDonationDate.value}");
    print("Location: ${location.value}");
  }
}
