import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AreaFilterController.dart';
import 'area_filter_card.dart';


class AreaFilterScreen extends StatelessWidget {
  final AreaFilterController controller =
  Get.put(AreaFilterController(), permanent: true);

  AreaFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red[900]),
          onPressed: () => Get.back(),
        ),
        title: const Text("Location"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.bloodtype, color: Colors.red[900]),
          ),
        ],
      ),
      body: Column(
        children: [
          // Location Search Box
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_on_outlined),
                hintText: "Search location...",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => controller.location.value = value,
            ),
          ),

          // Results List
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.results.length,
              itemBuilder: (context, index) {
                var item = controller.results[index];
                return Column(
                  children: [
                    AreaFilterCard(
                      name: item["name"] as String? ?? "",
                      specialty: item["specialty"] as String? ?? "",
                      hospital: item["hospital"] as String? ?? "",
                      rating: item["rating"] as int? ?? 0,
                      image: item["image"] as String? ?? "",
                    ),


                    // Call Now Button
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 70, right: 12, bottom: 12),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.call, color: Colors.white),
                        label: const Text("Call Now",
                            style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
