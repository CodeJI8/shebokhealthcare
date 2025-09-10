import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'thalassemia_register_controller.dart';

class ThalassemiaRegisterScreen extends StatelessWidget {
  final ThalassemiaRegisterController controller =
  Get.put(ThalassemiaRegisterController());

  Future<void> _pickImage(Rx<File?> target) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      target.value = File(picked.path);
    }
  }

  Widget _uploadBox(String label, Rx<File?> target) {
    return Obx(() => GestureDetector(
      onTap: () => _pickImage(target),
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: target.value == null
            ? Icon(Icons.add, size: 40, color: Colors.black54)
            : ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(target.value!, fit: BoxFit.cover),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bloodGroups = [
      "A+",
      "A-",
      "B+",
      "B-",
      "O+",
      "O-",
      "AB+",
      "AB-",
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red[900]),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Upload Boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _uploadBox("Blood Report", controller.bloodReport),
                _uploadBox("Prescription", controller.prescription),
              ],
            ),
            SizedBox(height: 15),

            Text("Upload Blood Report (CBC) And Prescription",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),

            SizedBox(height: 20),

            /// Blood Group Dropdown
            Obx(() => DropdownButtonFormField<String>(
              value: controller.selectedBloodGroup.value.isEmpty
                  ? null
                  : controller.selectedBloodGroup.value,
              items: bloodGroups
                  .map((bg) =>
                  DropdownMenuItem(value: bg, child: Text(bg)))
                  .toList(),
              onChanged: (val) =>
              controller.selectedBloodGroup.value = val ?? "",
              decoration: InputDecoration(
                labelText: "Select Blood Group",
                border: OutlineInputBorder(),
              ),
            )),

            SizedBox(height: 20),

            /// Show number checkbox
            Obx(() => CheckboxListTile(
              value: controller.showNumber.value,
              onChanged: controller.toggleShowNumber,
              title: Text("Show Your Number In The Member List"),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.red[900],
            )),

            Spacer(),

            /// Next Button
            Obx(() => ElevatedButton(
              onPressed: controller.canProceed
                  ? controller.submit
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.canProceed
                    ? Colors.red[900]
                    : Colors.red[900]!.withOpacity(0.5),
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: controller.isLoading.value
                  ? CircularProgressIndicator(
                  color: Colors.white, strokeWidth: 2)
                  : Text(
                "Next",
                style:
                TextStyle(color: Colors.white, fontSize: 16),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
