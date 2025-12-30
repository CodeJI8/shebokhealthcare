import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'HospitalCard.dart';

class HospitalListScreen extends StatelessWidget {
  const HospitalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hospitals = [
      {
        "image": "assets/hospital1.png",
        "name": "Mount Adora Hospital, Akhalia, Sylhet",
        "branch": "Branch Name",
        "phone": "018 90034843",
      },
      {
        "image": "assets/hospital2.png",
        "name": "Sylhet MAG Osmani Medical College Hospital",
        "branch": "Branch Name",
        "phone": "018 90034843",
      },
      {
        "image": "assets/hospital3.png",
        "name": "Square Hospitals Ltd.",
        "branch": "Branch Name",
        "phone": "018 90034843",
      },
      // Add more hospital maps here...
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Top Row: Back + Search
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
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
                      iconSize: 18, // Remove default padding for perfect centering
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 25, // Match the button's height
                    width: MediaQuery.of(context).size.width - 70, // Take up the remaining space
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        hintText: "Search",
                        filled: true,
                        fillColor: Color(0xFFF2F2F2),
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // 🔹 Hospital List
            Expanded(
              child: Container(
                color: Colors.white, // full screen white background
                child: ListView.builder(
                  itemCount: hospitals.length,
                  itemBuilder: (context, index) {
                    final hospital = hospitals[index];
                    return HospitalCard(
                      imagePath: hospital["image"]!,
                      name: hospital["name"]!,
                      branch: hospital["branch"]!,
                      phone: hospital["phone"]!,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
