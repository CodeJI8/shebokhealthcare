import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'SlotController.dart';

class AppointmentFormDialog extends StatefulWidget {
  final String doctorName;
  final String date;
  final Map<String, dynamic> slot;

  const AppointmentFormDialog({
    super.key,
    required this.doctorName,
    required this.date,
    required this.slot,
  });

  @override
  _AppointmentFormDialogState createState() => _AppointmentFormDialogState();
}

class _AppointmentFormDialogState extends State<AppointmentFormDialog> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter Your Details"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name TextField with outlined border
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 16), // Adding space between fields
            // Age TextField with outlined border
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 16), // Adding space between fields
            // Notes TextField with outlined border
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: "Notes",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Validate and collect input data
            final name = _nameController.text;
            final age = double.tryParse(_ageController.text);
            final notes = _notesController.text;

            if (name.isEmpty || age == null || age <= 0) {
              Get.snackbar("Error", "Please provide valid details");
              return;
            }

            // Call the bookAppointment method in the controller
            Get.find<SlotController>().bookAppointment(
              slotId: int.parse(widget.slot["slot_id"]),
              date: widget.date,
              name: name,
              age: age,
              notes: notes,
            );

            // Close the dialog
            Get.back();
          },
          child: const Text("Book Appointment"),
        ),
        TextButton(
          onPressed: () {
            // Close the dialog
            Get.back();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
