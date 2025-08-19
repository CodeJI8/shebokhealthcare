import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shebokhealthcare/ui/home/side_menu.dart';

import '../affiliated/HospitalListScreen.dart';
import '../post/requested_post_details.dart';

import '../widgets/BloodChip.dart';
import '../widgets/RequestCard.dart';

import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true, // for floating nav bar
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Top Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/logo.png", height: 60, color: Colors.red,), // Logo
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text("SOS", style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 10),
                      SideMenu(
                        onItemSelected: (value) {
                          switch (value) {
                            case 'hospital':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HospitalListScreen(), // <-- your hospitals page
                                ),
                              );
                              break;
                          }
                        },

                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),

              /// 🔹 Campaign Banner
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("JOIN OUR BLOOD CAMPAIGN",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    SizedBox(height: 5),
                    Text("Donate Date: ${controller.campaignDate.value}",
                        style: TextStyle(color: Colors.white)),
                  ],
                )),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  '"Be The Reason Someone Smiles Today – Donate Now"',
                  style: TextStyle(
                      color: Colors.red, fontStyle: FontStyle.italic),
                ),
              ),
              SizedBox(height: 15),

              /// 🔹 Action Buttons Grid
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.3,
                children: [
                  _actionButton("Request Blood", Colors.red[900]!, Icons.add),
                  _actionButton("Become A Donor", Colors.green, Icons.volunteer_activism),
                  _actionButton("Online Booking", Colors.yellow.shade700, Icons.book_online),
                  _actionButton("Foreign Treatment", Colors.blue, Icons.public),
                  _actionButton("Find Doctors", Colors.teal, Icons.local_hospital),
                  _actionButton("Thalassemia Club", Colors.green, Icons.group),
                ],
              ),
              SizedBox(height: 10),

              /// 🔹 About Us Button
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text("About Us", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 15),

              /// 🔹 Blood Needed
              Text("Blood Needed",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Obx(() => Wrap(
                spacing: 5,
                children: controller.bloodTypes
                    .map((type) => BloodChip(type: type))
                    .toList(),
              )),
              SizedBox(height: 15),

              /// 🔹 Requests
              Text("Requests",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Obx(() => Column(
                children: controller.requests
                    .map(
                      (req) => RequestCard(
                    title: req["title"]!,
                    name: req["name"]!,
                    disease: req["disease"]!,
                    bloodGroup: req["bloodGroup"]!,
                    status: req["status"]!,
                    onDetailsPressed: () {
                      Get.to(() => RequestedPostDetails()); // Navigate to details page
                    },
                  ),
                )
                    .toList(),
              )

              ),
              SizedBox(height: 80), // space for nav bar
            ],
          ),
        ),
      ),



    );
  }

  /// 🔹 Helper for Action Buttons
  Widget _actionButton(String text, Color color, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(text, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
