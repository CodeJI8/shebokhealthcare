import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../home/home.dart';
import '../widgets/BottomNav.dart';
import 'ProfileController.dart';


class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());
  final ImagePicker picker = ImagePicker();
  int _currentIndex = 1; // Set to 1 as Profile tab is selected by default

  Future<void> _pickImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo, color: Colors.blue),
              title: const Text("Choose from Gallery"),
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) controller.uploadProfileImage(picked.path);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.green),
              title: const Text("Take a Photo"),
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.camera);
                if (picked != null) controller.uploadProfileImage(picked.path);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Button
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.red[900], // Red background
                        borderRadius: BorderRadius.circular(5), // Rounded corners
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white), // White icon
                        onPressed: () => Get.back(),
                        padding: EdgeInsets.zero,
                        iconSize: 18,// Remove default padding for perfect centering
                      ),
                    ),


                    // KYC Status
                    Obx(() => GestureDetector(
                      onTap: () => controller.goToKycPage(),
                      child: Container(
                        height: 29,
                        width: 127,

                        decoration: BoxDecoration(
                          color: controller.kycStatus.value == "approved"
                              ? Colors.green
                              : (controller.kycStatus.value == "pending"
                              ? Colors.orange
                              : Colors.grey),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          controller.kycStatus.value.capitalizeFirst ?? "KYC",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Profile Card
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Profile Picture + Upload button
                    Stack(
                      children: [
                        Obx(() {
                          final img = controller.profileImage.value;
                          return CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: img.isNotEmpty
                                ? (img.startsWith("http")
                                ? NetworkImage(img)
                                : FileImage(File(img))) as ImageProvider
                                : const AssetImage('assets/create_profile.jpg'),
                          );
                        }),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => _pickImage(context),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.camera_alt,
                                  color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Name
                    Obx(() => Text(
                      controller.name.value.isNotEmpty
                          ? controller.name.value
                          : "Your Name",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    )),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              Divider(),
              // Info Section (Phone & Referral)
              _buildInfoCard(controller),
              const SizedBox(height: 30),

              // Logout Button
              ElevatedButton.icon(
                onPressed: controller.logout,
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text("Log Out",
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Center the floating action button
      floatingActionButton: BottomNav(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
          });

          // Switch the screen based on the selected index
          switch (index) {
            case 0:
              Get.to(() => HomeScreen());
              break;
            case 1:

              break;
          }
        },
      ),
    );
  }

  Widget _buildInfoCard(ProfileController controller) {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Obx(() => _buildInfoRow(Icons.phone, controller.phone.value)),
          Obx(() => _buildInfoRow(Icons.code, controller.referCode.value)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.red[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : "-",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
