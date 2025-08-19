import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ProfileController.dart';
import 'ProfileEditPage.dart';


class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true, // Needed for floating nav
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100), // Space for nav bar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back Button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
              ),

              // Profile Picture with Edit Button
              Stack(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),

                  // 🔹 Edit Button (positioned at bottom-right)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Handle edit action (e.g., open image picker)
                      },
                      child: Container(

                          // Example usage inside a widget
                        child: IconButton(
                          icon: Image.asset(
                            'assets/edit.png',
                            width: 37,
                            height: 37,
                          // optional tint (remove if you want original colors)
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileEditPage(),
                              ),
                            );
                          },
                        ),


                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),



              // Name
              Obx(() => Text(
                controller.name.value,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
              SizedBox(height: 10),

              // KYC Verification Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: Text("KYC Verification", style: TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 20),

              // Info Card
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Obx(() =>
                        _buildInfoRow(Icons.email, controller.email.value)),
                    Obx(() =>
                        _buildInfoRow(Icons.phone, controller.phone.value)),
                    Obx(() =>
                        _buildInfoRow(Icons.person, controller.gender.value)),
                    Obx(() =>
                        _buildInfoRow(Icons.water_drop, controller.bloodGroup.value)),
                    Obx(() =>
                        _buildInfoRow(Icons.health_and_safety, controller.healthStatus.value)),
                    Obx(() => _buildInfoRow(
                        Icons.calendar_today,
                        "Last Day Of Donation: ${controller.lastDonation.value}")),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Logout Button
              TextButton.icon(
                onPressed: controller.logout,
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text("Log Out", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),





    );
  }

  Widget _buildInfoRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.red),
          SizedBox(width: 10),
          Expanded(
              child: Text(value,
                  style: TextStyle(fontSize: 16, color: Colors.black))),
        ],
      ),
    );
  }
}
