import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'foreign_treatment_controller.dart';

class ForeignTreatmentScreen extends StatelessWidget {
  final ForeignTreatmentController controller =
  Get.put(ForeignTreatmentController());

  ForeignTreatmentScreen({super.key});

  Widget _inputField(String hint, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 9), // ↓ reduced
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red[900]),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Foreign Treatment Form",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30), // ↓ reduced
        child: Column(
          children: [
            _inputField("Email", controller.email),
            const SizedBox(height: 10), // ↓ reduced
            _inputField("Disease", controller.disease),
            const SizedBox(height: 10),
            _inputField("Duration (in months)", controller.duration),
            const SizedBox(height: 10),
            _inputField("Description (optional)", controller.description,
                maxLines: 3),

            const SizedBox(height: 16), // ↓ reduced

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[900],
                minimumSize: const Size(double.infinity, 40), // ↓ reduced
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: controller.submitForm,
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
