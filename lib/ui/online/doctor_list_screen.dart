import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'DoctorListController.dart';
import 'doctor_card.dart';

class DoctorListScreen extends StatelessWidget {
  final DoctorListController controller =
  Get.put(DoctorListController(), permanent: true);

  DoctorListScreen({super.key});

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
        title: const Text("Doctors List",
            style: TextStyle(color: Colors.black)),
        centerTitle: false,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[900],
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Get.snackbar("Appointments", "My Appointments Clicked");
            },
            child: const Text("My Appointments",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(width: 10),
          Icon(Icons.filter_list, color: Colors.black),
          const SizedBox(width: 10),
        ],
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: controller.doctors.length,
          itemBuilder: (context, index) {
            final doctor = controller.doctors[index];
            return DoctorCard(
              name: doctor["name"]!,
              specialty: doctor["specialty"]!,
              address: doctor["address"]!,
              image: doctor["image"]!,
              onBook: () {
                Get.snackbar("Booked",
                    "Appointment booked with ${doctor["name"]}");
              },
            );
          },
        ),
      ),
    );
  }
}
