import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ✅ for responsive scaling
import 'package:shebokhealthcare/ui/home/home.dart';
import '../../ui/widgets/bd_divisions.dart';
import 'ProfileCreateController.dart';

class ProfileCreatePage extends StatelessWidget {
  ProfileCreatePage({super.key});

  final ProfileCreateController controller = Get.put(ProfileCreateController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.9;

    return ScreenUtilInit(
      designSize: const Size(390, 844), // base design
      builder: (context, child) => Scaffold(
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
                width: 200.w * 0.9, // −10%
                fit: BoxFit.cover,
              ),
            ),

            // Top-right spot
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/top_spot.png',
                width: 200.w * 0.9, // −10%
                fit: BoxFit.cover,
              ),
            ),

            // Content
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w * 0.9,
                    vertical: 16.h * 0.9,
                  ),
                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        "assets/logo.png",
                        height: 100.h * 0.9, // smaller
                      ),
                      SizedBox(height: 20.h * 0.9),

                      // White Card
                      Container(
                        width: cardWidth,
                        padding: EdgeInsets.all(16.w * 0.9),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          children: [
                            // Create Profile Button
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[900],
                                minimumSize:
                                Size(double.infinity, 44.h * 0.9), // −10%
                              ),
                              child: Text(
                                "Create a profile",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp * 0.9,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h * 0.9),

                            // Blood Group
                            TextField(
                              onChanged: (v) =>
                              controller.bloodGroup.value = v,
                              decoration: _inputDecoration("Blood Group"),
                              style: TextStyle(fontSize: 14.sp * 0.9),
                            ),
                            SizedBox(height: 12.h * 0.9),

                            // Medical Info Dropdown
                            DropdownButtonFormField<String>(
                              decoration:
                              _inputDecoration("Medical info (optional)"),
                              items: ['Diabetes', 'Hypertension', 'Heart Disease']
                                  .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      fontSize: 13.sp * 0.9),
                                ),
                              ))
                                  .toList(),
                              onChanged: (val) =>
                              controller.medicalInfo.value = val ?? '',
                            ),
                            SizedBox(height: 12.h * 0.9),

                            // Last Blood Donation Date
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
                                  controller.lastDonationDate.value =
                                      formattedDate;
                                }
                              },
                              decoration: _inputDecoration(
                                  "Last Blood Donation Date"),
                              style: TextStyle(fontSize: 13.sp * 0.9, color: Colors.black),
                            ),
                            SizedBox(height: 12.h * 0.9),

                            // Location Section
                            Obx(() {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(color: Colors.red[900]!, width: 1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.my_location, color: Colors.red[900], size: 20.sp),
                                            SizedBox(width: 8.w),
                                            Text(
                                              "Auto Detect My Location",
                                              style: TextStyle(
                                                fontSize: 13.sp * 0.9,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Obx(() => Switch(
                                          value: controller.useLocation.value,
                                          activeColor: Colors.red[900],
                                          onChanged: (val) async {
                                            controller.useLocation.value = val;

                                            if (val) {
                                              // Ask for location permission
                                              LocationPermission permission = await Geolocator.checkPermission();
                                              if (permission == LocationPermission.denied) {
                                                permission = await Geolocator.requestPermission();
                                              }

                                              if (permission == LocationPermission.deniedForever ||
                                                  permission == LocationPermission.denied) {
                                                Get.snackbar(
                                                  "Permission Denied",
                                                  "Please enable location permission from settings",
                                                );
                                                controller.useLocation.value = false;
                                                return;
                                              }

                                              // Get current position
                                              Position pos = await Geolocator.getCurrentPosition(
                                                desiredAccuracy: LocationAccuracy.high,
                                              );

                                              controller.latitude.value = pos.latitude;
                                              controller.longitude.value = pos.longitude;
                                              print("📍 Lat: ${pos.latitude}, Lng: ${pos.longitude}");
                                            }
                                          },
                                        ))

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12.h * 0.9),

                                  if (!controller.useLocation.value) ...[
                                    // Division Dropdown
                                    // Division Dropdown
                                    DropdownSearch<String>(
                                      popupProps: const PopupProps.menu(showSearchBox: true),
                                      items: bdDivisions.keys.toList(), // All 8 divisions
                                      dropdownDecoratorProps: DropDownDecoratorProps(
                                        dropdownSearchDecoration: _inputDecoration("Select Division"),
                                      ),
                                      onChanged: (val) {
                                        controller.selectedDivision.value = val ?? '';
                                        controller.selectedDistrict.value = '';
                                      },
                                    ),

                                    SizedBox(height: 12.h * 0.9),

// District Dropdown
                                    Obx(() {
                                      final division = controller.selectedDivision.value;
                                      final districtList = division.isNotEmpty
                                          ? bdDivisions[division]!
                                          : <String>[];

                                      return DropdownSearch<String>(
                                        items: districtList,
                                        popupProps: const PopupProps.menu(showSearchBox: true),
                                        dropdownDecoratorProps: DropDownDecoratorProps(
                                          dropdownSearchDecoration: _inputDecoration("Select District"),
                                        ),
                                        onChanged: (val) {
                                          controller.selectedDistrict.value = val ?? '';
                                          print("Selected District: $val");
                                        },
                                      );
                                    }),

                                  ],
                                ],
                              );

                            }),
                            SizedBox(height: 16.h * 0.9),

                            // Next Button
                            Obx(() => ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () async {
                                await controller.createProfile();
                                Get.to(HomeScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[900],
                                minimumSize: Size(double.infinity, 48.h * 0.9),
                              ),
                              child: controller.isLoading.value
                                  ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                                  : Text(
                                "Next",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp * 0.9,
                                ),
                              ),
                            )),

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
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontSize: 13.sp * 0.9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.red[900]!, width: 1.5),
      ),
    );
  }
}
