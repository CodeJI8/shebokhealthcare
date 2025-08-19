import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shebokhealthcare/auth/kyc/KycVerificationController.dart';
import 'package:shebokhealthcare/auth/kyc/KycVerificationPage.dart';
import 'ProfileCreateController.dart';


class ProfileCreatePage extends StatelessWidget {
  ProfileCreatePage({super.key});

  final ProfileCreateController controller =
  Get.put(ProfileCreateController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.9;

    return Scaffold(
      body: Stack(
        children: [
          // Solid red background
          Container(color: const Color(0xFFBD1F1C)),

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

          // Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    // Logo
                    Image.asset(
                      "assets/logo.png",
                      height: 100,
                    ),
                    const SizedBox(height: 20),

                    // White Card
                    Container(
                      width: cardWidth,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          // Create Profile Button
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[900],
                            ),
                            child: const Text(
                              "Create a profile",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Profile Picture Placeholder
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.add_circle_outline, size: 32, color: Colors.black,),
                          ),
                          const SizedBox(height: 24),

                          // Blood Group
                          TextField(
                            onChanged: (v) => controller.bloodGroup.value = v,
                            decoration: _inputDecoration("Blood Group"),
                          ),
                          const SizedBox(height: 12),

                          // Medical Info Dropdown
                          DropdownButtonFormField<String>(
                            decoration: _inputDecoration(
                                "Medical info (optional)"),
                            items: [
                              'Diabetes',
                              'Hypertension',
                              'Heart Disease'
                            ]
                                .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                                .toList(),
                            onChanged: (val) =>
                            controller.medicalInfo.value = val ?? '',
                          ),
                          const SizedBox(height: 12),

                          // Last Blood Donation Date
                          // Last Blood Donation Date Picker
                          TextField(
                            controller: TextEditingController(
                              text: controller.lastDonationDate.value,
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

                                controller.lastDonationDate.value = formattedDate;
                              }
                            },
                            decoration: _inputDecoration("Last Blood Donation Date"),
                          ),

                          const SizedBox(height: 12),

                          // Location
                          TextField(
                            onChanged: (v) => controller.location.value = v,
                            decoration: _inputDecoration("Location"),
                          ),
                          const SizedBox(height: 16),

                          // Next Button
                          ElevatedButton(
                            // onPressed: controller.createProfile,
                            onPressed: (){
                              Get.to(KycVerificationPage());
                              
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[900],
                              minimumSize: const Size(double.infinity, 48),
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

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    );
  }
}
