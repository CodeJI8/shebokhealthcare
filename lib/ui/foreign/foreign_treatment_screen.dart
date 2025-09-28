import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'foreign_treatment_controller.dart';

class ForeignTreatmentScreen extends StatelessWidget {
  final ForeignTreatmentController controller = Get.put(ForeignTreatmentController());

  ForeignTreatmentScreen({super.key});

  Widget _inputField(String hint, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Adds spacing between input fields
      child: TextField(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // Wrap with SafeArea to avoid UI elements obstructing the content
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20), // ↓ reduced for more compact view
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3, bottom: 20), // Adjust padding for better spacing
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Colors.red[900],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(),
                      padding: EdgeInsets.zero,
                      iconSize: 18,
                    ),
                  ),
                ),
              ),


              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20), // Adds some space between the text and form
                  child: Text(
                    "Foreign Treatment Form",
                    style: TextStyle(
                      fontSize: 20, // Adjust font size as needed
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              _inputField("Email", controller.email),
              _inputField("Disease", controller.disease),
              _inputField("Duration of disease", controller.duration),
              _inputField("Description (optional)", controller.description, maxLines: 3),

              // Submit button with some padding to align with the fields
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20), // Added vertical padding to separate the button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    minimumSize: const Size(double.infinity, 45), // Increased button height
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
