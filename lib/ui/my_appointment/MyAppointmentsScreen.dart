// my_appointments_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shebokhealthcare/ui/my_appointment/appointment_card.dart';
import '../online/doctor_card.dart';
import 'MyAppointmentsController.dart';


class MyAppointmentsScreen extends StatelessWidget {
  final MyAppointmentsController controller =
  Get.put(MyAppointmentsController());

  MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Appointments", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.appointments.isEmpty) {
          return const Center(child: Text("No appointments found"));
        }

        return ListView.builder(
          itemCount: controller.appointments.length,
          itemBuilder: (context, index) {
            final appointment = controller.appointments[index];

            return AppointmentCard(
              doctorId: int.tryParse(appointment["id"].toString()) ?? 0,
              name: appointment["name"] ?? "N/A",
              specialty: appointment["specialization"] ?? "N/A",
              date: appointment["date"] ?? "N/A",
              time: appointment["start_time"] ?? "N/A",
              status: appointment["status"] ?? "Unknown",
              image: appointment["pro_path"],
            );
          },
        );
      }),
    );
  }
}
