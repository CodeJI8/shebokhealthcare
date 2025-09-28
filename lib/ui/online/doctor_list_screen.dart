// DoctorListScreen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../my_appointment/MyAppointmentsScreen.dart';
import 'DoctorListController.dart';
import 'SlotController.dart';
import 'SlotSelectionSheet.dart';
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
        title: const Text("Doctors List", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => MyAppointmentsScreen());
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            child: const Text(
              "My Appointments",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          const SizedBox(width: 10),
        ],

      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.doctors.isEmpty) {
          return const Center(child: Text("No doctors available"));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (!controller.isMoreLoading.value &&
                controller.hasMore.value &&
                scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 200) {
              controller.loadNextPage();
            }
            return false;
          },
          child: ListView.builder(
            itemCount: controller.doctors.length +
                (controller.isMoreLoading.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.doctors.length) {
                final doctor = controller.doctors[index];

                return InkWell(
                  onTap: () {
                    _showDoctorDetailsDialog(context, doctor); // 👈 new
                  },
                  child: DoctorCard(
                    doctorId: int.tryParse(doctor["id"].toString()) ?? 0,
                    name: doctor["name"] ?? "N/A",
                    specialty: doctor["specialization"] ?? "N/A",
                    education: doctor["education"] ?? "",
                    experience: doctor["experience"] ?? "0",
                    fee: doctor["fee"] ?? "0",
                    image: doctor["pro_path"],
                    onBook: () {
                      _bookAppointment(context, doctor); // 👈 moved booking logic here
                    },
                  ),
                );

              } else {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        );
      }),
    );
  }
}

void _showDoctorDetailsDialog(BuildContext context, Map<String, dynamic> doctor) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: (doctor["pro_path"] != null &&
                  doctor["pro_path"].toString().isNotEmpty)
                  ? NetworkImage(doctor["pro_path"])
                  : const AssetImage("assets/doctor_placeholder.png")
              as ImageProvider,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor["name"] ?? "N/A",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    doctor["specialization"] ?? "N/A",
                    style: const TextStyle(color: Colors.green, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Education: ${doctor["education"] ?? "N/A"}"),
              const SizedBox(height: 6),
              Text("Experience: ${doctor["experience"] ?? "0"} yrs"),
              const SizedBox(height: 6),
              Text("Fee: ৳${doctor["fee"] ?? "0"}"),
              const SizedBox(height: 6),
              Text("Address: ${doctor["address"] ?? "N/A"}"),
              const SizedBox(height: 6),
              Text("Bio: ${doctor["bio"] ?? "No details"}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close", style: TextStyle(color: Colors.black),),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context); // close dialog
              _bookAppointment(context, doctor); // 👈 reuse booking
            },
            child: const Text("Book Appointment", style: TextStyle(color: Colors.white),),
          ),
        ],
      );
    },
  );
}

void _bookAppointment(BuildContext context, Map<String, dynamic> doctor) async {
  final slotController = Get.put(SlotController());

  final picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 30)),
  );

  if (picked == null) return;

  final date = picked.toIso8601String().split("T").first;

  await slotController.getSlots(
    int.tryParse(doctor["id"].toString()) ?? 0,
    date,
  );

  Get.bottomSheet(
    SlotSelectionSheet(
      doctorName: doctor["name"],
      date: date,
    ),
    isScrollControlled: true,
  );
}

