import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../request_blood/RequestCard.dart';
import 'requested_post_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestedPostDetails extends StatelessWidget {
  final RequestedPostController controller = Get.put(RequestedPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 40,

                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red[900],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),

                  // Profile/Search Button
                  GestureDetector(
                    onTap: () {
                      // Do something here
                    },
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red[900],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // 🔹 Post details
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.title.value,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(controller.hospital.value),
                  Text(controller.name.value),
                  Text(controller.disease.value),
                  Text(
                    controller.bloodGroup.value,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Contact: ${controller.contactNumber.value} (${controller.contactName.value})",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Needed By: ${controller.neededBy.value}"),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          _launchDialer(controller.contactNumber.value),
                      icon: Icon(Icons.phone, color: Colors.white),
                      label: Text("Call Now"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              )),

              SizedBox(height: 20),

              // 🔹 Related blood group section
              Text(
                "Related Blood Group",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Obx(() => Column(
                children: controller.relatedRequests
                    .map((req) => RequestCard(
                  title: req["title"]!,
                  name: req["name"]!,
                  disease: req["disease"]!,
                  bloodGroup: req["bloodGroup"]!,
                  status: req["status"]!,
                ))
                    .toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _launchDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      Get.snackbar("Error", "Could not launch dialer");
    }
  }
}
