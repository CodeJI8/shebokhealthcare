import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shebokhealthcare/MainScreen.dart';
import 'package:shebokhealthcare/ui/home/home.dart';

import 'KycVerificationController.dart';


class KycVerificationPage extends StatelessWidget {
  KycVerificationPage({super.key});

  final KycVerificationController controller =
  Get.put(KycVerificationController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.9;

    return Scaffold(
      body: Stack(
        children: [
          // Background color
          Container(
            color: const Color(0xFFBD1F1C),
          ),

          // Bottom-left spot
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/spot.png',
              width: 200,
              fit: BoxFit.cover,
            ),
          ),

          // Top-right spot
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/top_spot.png',
              width: 200,
              fit: BoxFit.cover,
            ),
          ),

          // Page content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Image.asset(
                      "assets/logo.png",
                      height: 100,
                    ),
                    const SizedBox(height: 20),

                    // Card Container
                    Container(
                      width: cardWidth,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          // Title Button
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[900],
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: const Text("KYC Verification", style: TextStyle(
                              color: Colors.white,
                            ),),
                          ),
                          const SizedBox(height: 16),

                          // Upload Box
                          GestureDetector(
                            onTap: controller.pickDocument,
                            child: Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.red, width: 1),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200],
                              ),
                              child: Center(
                                child: Obx(() => Text(
                                  controller.documentPath.value.isEmpty
                                      ? "Add your Passport or NID"
                                      : controller.documentPath.value,
                                  style: const TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          const Text(
                            "KYC-Verified Users Will Get Discounts At Affiliated Hospitals.",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 16),

                          // Next Button
                          ElevatedButton(
                            // onPressed: controller.submitKyc,
                            onPressed:(){
                              Get.to(MainScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[900],
                              minimumSize:
                              const Size(double.infinity, 48),
                            ),
                            child: const Text(
                              "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
