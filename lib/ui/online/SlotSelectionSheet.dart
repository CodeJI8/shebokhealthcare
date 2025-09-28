import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AppointmentFormDialog.dart';
import 'SlotController.dart';

class SlotSelectionSheet extends StatelessWidget {
  final String doctorName;
  final String date;

  const SlotSelectionSheet({
    super.key,
    required this.doctorName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final SlotController controller = Get.find();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.slots.isEmpty) {
          return const Center(child: Text("No slots available"));
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Available Slots with $doctorName on $date",
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.slots.length,
                itemBuilder: (context, index) {
                  final slot = controller.slots[index];
                  return ListTile(
                    leading: const Icon(Icons.access_time),
                    title: Text(slot["start_time"]),
                    onTap: () {
                      // Prompt for patient details
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AppointmentFormDialog(
                            doctorName: doctorName,
                            date: date,
                            slot: slot,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
