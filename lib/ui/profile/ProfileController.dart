import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = "Fouzia Hussain".obs;
  var email = "blood27@gmail.com".obs;
  var phone = "019 474 738".obs;
  var gender = "Female".obs;
  var bloodGroup = "O+".obs;
  var healthStatus = "Healthy".obs;
  var lastDonation = "27 May 2025".obs;

  // Example: Editing email
  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  // Log out logic
  void logout() {
    // Add your logout code
  }
}
