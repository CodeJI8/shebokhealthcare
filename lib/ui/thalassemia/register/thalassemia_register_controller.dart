import 'package:get/get.dart';
import 'dart:io';

import 'package:shebokhealthcare/ui/thalassemia/register/thalassemia_register_screen.dart';

class ThalassemiaRegisterController extends GetxController {
  var bloodReport = Rx<File?>(null);
  var prescription = Rx<File?>(null);
  var showNumber = false.obs;

  bool get canProceed => bloodReport.value != null && prescription.value != null;

  void toggleShowNumber(bool? value) {
    showNumber.value = value ?? false;
  }



  void submit() {
    if (!canProceed) return;
    print("Blood Report: ${bloodReport.value}");
    print("Prescription: ${prescription.value}");
    print("Show Number: ${showNumber.value}");
    // TODO: upload to backend
  }
}
