import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'DonationHistoryCard.dart';
import 'DonationHistoryController.dart';


class DonationHistoryPage extends StatelessWidget {
  final DonationHistoryController controller =
  Get.put(DonationHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation History"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red[900]),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.donations.isEmpty) {
          return const Center(child: Text("No donation history found"));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.donations.length,
                itemBuilder: (context, index) {
                  final donation = controller.donations[index];
                  return DonationHistoryCard(
                    donation: donation,
                    onRemove: () {
                      // TODO: Implement remove API if available
                      print("Remove donation ${donation.donationId}");
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
