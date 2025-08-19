import 'package:get/get.dart';

class KycVerificationController extends GetxController {
  var documentPath = ''.obs;

  void pickDocument() async {
    // TODO: Implement file picker here
    // For now, let's just simulate a picked file
    documentPath.value = "passport_or_nid.pdf";
  }

  void submitKyc() {
    if (documentPath.value.isEmpty) {
      print("Please upload a document");
    } else {
      print("KYC Submitted: ${documentPath.value}");
    }
  }
}
