import 'package:flutter/material.dart';
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
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
