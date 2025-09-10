import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bd_divisions.dart';
import 'AreaFilterController.dart';
import 'area_filter_card.dart';

class AreaFilterScreen extends StatefulWidget {
  const AreaFilterScreen({super.key});

  @override
  State<AreaFilterScreen> createState() => _AreaFilterScreenState();
}

class _AreaFilterScreenState extends State<AreaFilterScreen> {
  final AreaFilterController controller =
  Get.put(AreaFilterController(), permanent: true);

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // 👇 Listen for scroll to bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red[900]),
          onPressed: () => Get.back(),
        ),
        title: const Text("Find Doctors"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🔹 If location denied → show dropdowns
          Obx(() {
            if (!controller.isLocationAllowed.value) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    // Division Dropdown
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

                    // District Dropdown (dependent on Division)
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

          // 🔹 Results List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.results.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.results.isEmpty) {
                return const Center(child: Text("No doctors found"));
              }

              return ListView.builder(
                controller: _scrollController, // 👈 attach controller
                itemCount: controller.results.length + 1, // +1 for loader
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
                    // bottom loader
                    if (controller.isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (controller.currentPage.value >=
                        controller.totalPages.value) {
                      return const Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(child: Text("✅ No more results")),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
