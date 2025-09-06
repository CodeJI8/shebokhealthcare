import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/bd_divisions.dart';
import 'BloodRequestController.dart';

class BloodRequestScreen extends StatelessWidget {
  BloodRequestScreen({super.key});

  final BloodRequestController controller = Get.put(BloodRequestController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: const Text("Post Blood Request", style:  TextStyle(color: Colors.white),),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w * 0.9), // −10%
            child: Column(
              children: [
                // 🔹 Title
                TextField(
                  onChanged: (v) => controller.requestTitleController.text = v,
                  decoration: _inputDecoration("Post Title"),
                  style: TextStyle(fontSize: 14.sp * 0.9),
                ),
                SizedBox(height: 12.h * 0.9),

                // 🔹 Disease
                TextField(
                  onChanged: (v) => controller.diseaseController.text = v,
                  decoration: _inputDecoration("Disease Name"),
                  style: TextStyle(fontSize: 14.sp * 0.9),
                ),
                SizedBox(height: 12.h * 0.9),

                // 🔹 Hospital
                TextField(
                  onChanged: (v) =>
                  controller.hospitalAddressController.text = v,
                  decoration: _inputDecoration("Hospital Details"),
                  style: TextStyle(fontSize: 14.sp * 0.9),
                ),
                SizedBox(height: 12.h * 0.9),

                // 🔹 Blood Group
                DropdownSearch<String>(
                  items: controller.bloodGroups,
                  popupProps: const PopupProps.menu(showSearchBox: true),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: _inputDecoration("Blood Group"),
                  ),
                  onChanged: (val) =>
                  controller.selectedBloodGroup.value = val ?? '',
                ),
                SizedBox(height: 12.h * 0.9),

                // 🔹 Date Picker
                Obx(() => TextField(
                  controller: TextEditingController(
                    text: controller.requestDate.value,
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                    );
                    if (pickedDate != null) {
                      controller.requestDate.value =
                      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    }
                  },
                  decoration:
                  _inputDecoration("Date Needed (YYYY-MM-DD)"),
                  style: TextStyle(fontSize: 14.sp * 0.9),
                )),
                SizedBox(height: 12.h * 0.9),

                // 🔹 Patient Name
                TextField(
                  onChanged: (v) =>
                  controller.patientNameController.text = v,
                  decoration: _inputDecoration("Patient Name"),
                  style: TextStyle(fontSize: 14.sp * 0.9),
                ),
                SizedBox(height: 16.h * 0.9),

                // 🔹 Location Section
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w * 0.9, vertical: 8.h * 0.9),
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
                                Icon(Icons.my_location,
                                    color: Colors.red[900], size: 20.sp * 0.9),
                                SizedBox(width: 8.w * 0.9),
                                Text(
                                  "Auto Detect My Location",
                                  style: TextStyle(
                                    fontSize: 13.sp * 0.9,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: controller.useLocation.value,
                              activeColor: Colors.red[900],
                              onChanged: (val) async {
                                controller.useLocation.value = val;

                                if (val) {
                                  LocationPermission permission =
                                  await Geolocator.checkPermission();
                                  if (permission == LocationPermission.denied) {
                                    permission =
                                    await Geolocator.requestPermission();
                                  }
                                  if (permission ==
                                      LocationPermission.deniedForever ||
                                      permission == LocationPermission.denied) {
                                    Get.snackbar("Permission Denied",
                                        "Please enable location permission");
                                    controller.useLocation.value = false;
                                    return;
                                  }

                                  Position pos =
                                  await Geolocator.getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.high,
                                  );
                                  controller.latitude.value = pos.latitude;
                                  controller.longitude.value = pos.longitude;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h * 0.9),

                      if (!controller.useLocation.value) ...[
                        DropdownSearch<String>(
                          popupProps:
                          const PopupProps.menu(showSearchBox: true),
                          items: bdDivisions.keys.toList(),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration:
                            _inputDecoration("Select Division"),
                          ),
                          onChanged: (val) {
                            controller.selectedDivision.value = val ?? '';
                            controller.selectedDistrict.value = '';
                          },
                        ),
                        SizedBox(height: 12.h * 0.9),
                        Obx(() {
                          final division = controller.selectedDivision.value;
                          final districtList = division.isNotEmpty
                              ? bdDivisions[division]!
                              : <String>[];

                          return DropdownSearch<String>(
                            items: districtList,
                            popupProps:
                            const PopupProps.menu(showSearchBox: true),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                              _inputDecoration("Select District"),
                            ),
                            onChanged: (val) {
                              controller.selectedDistrict.value = val ?? '';
                            },
                          );
                        }),
                      ],
                    ],
                  );
                }),
                SizedBox(height: 20.h * 0.9),

                // 🔹 Submit Button
                Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                    await controller.submitRequest(); // ✅ fixed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    minimumSize: Size(double.infinity, 48.h * 0.9),
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                    width: 20.w * 0.9,
                    height: 20.w * 0.9,
                    child: const CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2),
                  )
                      : Text("Submit Request",
                      style: TextStyle(
                          color: Colors.white, fontSize: 14.sp * 0.9)),
                )),
              ],
            ),
          ),
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
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.red[900]!, width: 1.5),
      ),
    );
  }
}
