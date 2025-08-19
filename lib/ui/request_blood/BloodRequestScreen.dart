import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'BloodRequestController.dart';


class BloodRequestScreen extends StatelessWidget {
  final BloodRequestController controller = Get.put(BloodRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Requisition Post"),
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
          children: [
            TextField(
              controller: controller.requestTitleController,
              decoration: InputDecoration(
                labelText: "Request Title",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: controller.hospitalAddressController,
              decoration: InputDecoration(
                labelText: "Hospital Address",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: controller.patientNameController,
              decoration: InputDecoration(
                labelText: "Patient's Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: controller.diseaseController,
              decoration: InputDecoration(
                labelText: "Disease",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            Obx(() => DropdownButtonFormField<String>(
              value: controller.selectedBloodGroup.value.isEmpty
                  ? null
                  : controller.selectedBloodGroup.value,
              decoration: InputDecoration(
                labelText: "Blood Group",
                border: OutlineInputBorder(),
              ),
              items: controller.bloodGroups
                  .map((bg) =>
                  DropdownMenuItem(value: bg, child: Text(bg)))
                  .toList(),
              onChanged: (value) {
                controller.selectedBloodGroup.value = value!;
              },
            )),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: controller.submitRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor:  Colors.red[900],
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Next", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
