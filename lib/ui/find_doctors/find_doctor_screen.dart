import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bd_divisions.dart';
import 'find_doctor_controller.dart';
import 'find_doctors_card.dart';

class FindDoctorScreen extends StatefulWidget {
  const FindDoctorScreen({super.key});

  @override
  State<FindDoctorScreen> createState() => _FindDoctorScreenState();
}

class _FindDoctorScreenState extends State<FindDoctorScreen> {
  final FindDoctorController controller = Get.put(FindDoctorController(), permanent: true);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        controller.loadMoreDoctors();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5), // Padding for the entire screen
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18), // Adjust the padding as needed
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Colors.red[900],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(),
                      padding: EdgeInsets.zero,
                      iconSize: 18,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Obx(() {
                if (!controller.isLocationAllowed.value) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: controller.selectedDivision.value.isEmpty
                              ? null
                              : controller.selectedDivision.value,
                          decoration: InputDecoration(
                            labelText: "Select Division",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: bdDivisions.keys
                              .map((div) => DropdownMenuItem(
                            value: div,
                            child: Text(div),
                          ))
                              .toList(),
                          onChanged: (val) {
                            controller.selectedDivision.value = val ?? '';
                            controller.selectedDistrict.value = '';
                          },
                        ),
                        const SizedBox(height: 12),
                        Obx(() {
                          final division = controller.selectedDivision.value;
                          final districts = division.isNotEmpty
                              ? bdDivisions[division]!
                              : <String>[];

                          return DropdownButtonFormField<String>(
                            value: controller.selectedDistrict.value.isEmpty
                                ? null
                                : controller.selectedDistrict.value,
                            decoration: InputDecoration(
                              labelText: "Select District",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: districts
                                .map((d) => DropdownMenuItem(
                              value: d,
                              child: Text(d),
                            ))
                                .toList(),
                            onChanged: (val) {
                              controller.selectedDistrict.value = val ?? '';
                              if (val != null) {
                                controller.location.value = val;
                                controller.fetchDoctors(page: 1, isLoadMore: false);
                              }
                            },
                          );
                        }),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value && controller.results.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.results.isEmpty) {
                    return const Center(child: Text("No doctors found"));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 12.0), // Matching the left alignment with the back button
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: controller.results.length + 1,
                      itemBuilder: (context, index) {
                        if (index < controller.results.length) {
                          var item = controller.results[index];
                          return AreaFilterCard(
                            name: item["name"] ?? "Unknown",
                            phone: item["phone"] ?? "N/A",
                            address: item["address"] ?? "",
                            image: item["img_path"],
                            distanceKm: item["distance_km"] != null
                                ? double.tryParse(item["distance_km"].toString())
                                : null,
                          );
                        } else {
                          if (controller.isLoading.value) {
                            return const Padding(
                              padding: EdgeInsets.all(12),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else if (controller.currentPage.value >= controller.totalPages.value) {
                            return const Padding(
                              padding: EdgeInsets.all(12),
                              child: Center(child: Text("✅ No more results")),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


