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
      body: SafeArea(  // Ensure the content doesn't go under system UI
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0), // Adjust padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.red[900], // Red background
                        borderRadius: BorderRadius.circular(5), // 5px radius
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white, // White icon
                        size: 16, // Icon size
                      ),
                    ),
                    onPressed: () => Get.back(),
                  ),
                  Image.asset(
                    'assets/logo.png', // Replace with your logo image path
                    width: 65,  // Set width to 65
                    height: 61, // Set height to 61
                    color: Colors.red[900],  // Apply color to the image
                  ),

                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.donations.isEmpty) {
                  return const Center(child: Text("No donation history found"));
                }
                return ListView.builder(
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
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
