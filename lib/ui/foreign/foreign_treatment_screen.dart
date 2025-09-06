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
        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _inputField("Enter Full Name", controller.fullName),
            const SizedBox(height: 12),
            _inputField("Gender", controller.gender),
            const SizedBox(height: 12),
            _inputField("Address", controller.address),
            const SizedBox(height: 12),
            _inputField("Disease", controller.disease),
            const SizedBox(height: 12),
            _inputField("Duration Of Disease", controller.duration),
            const SizedBox(height: 12),
            _inputField("Email", controller.email),
            const SizedBox(height: 12),
            _inputField("Consultancy Name", controller.consultancy),
            const SizedBox(height: 12),
            _inputField("Description", controller.description, maxLines: 4),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[900],
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: controller.submitForm,
              child: const Text("Next", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
