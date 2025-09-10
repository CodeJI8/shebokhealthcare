import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shebokhealthcare/auth/profile/profile_create_page.dart';
import 'package:shebokhealthcare/ui/find_doctors/area_filter_screen.dart';
import 'package:shebokhealthcare/ui/home/side_menu.dart';
import 'package:shebokhealthcare/ui/online/doctor_list_screen.dart';
import 'package:shebokhealthcare/ui/thalassemia/thalassemia_screen.dart';
import '../add_post/my_post_screen.dart';
import '../affiliated/HospitalListScreen.dart';
import '../foreign/foreign_treatment_screen.dart';
import '../post/requested_post_details.dart';
import '../request_blood/BloodRequestScreen.dart';
import '../widgets/BloodChip.dart';
import '../request_blood/RequestCard.dart';
import '../widgets/showReferralCodePopup.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(12.w * 1.1), // +10%
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 Top Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      height: 60.h * 1.1, // +10%
                      color: Colors.red,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[900],
                            minimumSize: Size(70.w * 1.1, 35.h * 1.1), // bigger
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            "SOS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp * 1.1, // +10%
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w * 1.1),
                        SideMenu(
                          onItemSelected: (value) async {
                            switch (value) {
                              case 'hospital':
                                Get.to(() => const HospitalListScreen());
                                break;
                              case 'post':
                                Get.to(() => MyPostScreen());
                                break;
                              case 'logout':
                                final shouldLogout = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text("Logout"),
                                    content: const Text(
                                        "Are you sure you want to log out?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(false),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(true),
                                        child: const Text("Logout"),
                                      ),
                                    ],
                                  ),
                                );
                                if (shouldLogout == true) {
                                  final prefs =
                                  await SharedPreferences.getInstance();
                                  await prefs.clear();
                                  Get.offAllNamed("/login");
                                }
                                break;
                              case 'refer':
                                showReferralCodePopup(context, "161016");
                                break;
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.h * 1.1),

                /// 🔹 Campaign Banner
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(14.w * 1.1),
                  decoration: BoxDecoration(
                    color: Colors.red[900],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Obx(
                        () => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "JOIN OUR BLOOD CAMPAIGN",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp * 1.1,
                          ),
                        ),
                        SizedBox(height: 4.h * 1.1),
                        Text(
                          "Donate Date: ${controller.campaignDate.value}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp * 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4.h * 1.1),
                Center(
                  child: Text(
                    '"Be The Reason Someone Smiles Today – Donate Now"',
                    style: TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                      fontSize: 9.sp * 1.1,
                    ),
                  ),
                ),
                SizedBox(height: 12.h * 1.1),

                /// 🔹 Action Buttons Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.h * 1.1,
                  crossAxisSpacing: 8.w * 1.1,
                  childAspectRatio: 2.3,
                  children: [
                    _actionButton("Request Blood", Colors.red[900]!, Icons.add,
                            () {
                          Get.to(() => BloodRequestScreen());
                        }),
                    _actionButton("Become A Donor", Colors.green,
                        Icons.volunteer_activism, () {
                          Get.to(() => ProfileCreatePage());
                        }),
                    _actionButton("Online Booking", Colors.yellow.shade700,
                        Icons.book_online, () {
                          Get.to(() => DoctorListScreen());
                        }),
                    _actionButton("Foreign Treatment", Colors.blue, Icons.public,
                            () {
                          Get.to(() => ForeignTreatmentScreen());
                        }),
                    _actionButton(
                        "Find Doctors", Colors.teal, Icons.local_hospital, () {
                      Get.to(() => AreaFilterScreen());
                    }),
                    _actionButton("Thalassemia Club", Colors.green, Icons.group,
                            () {
                          Get.to(() => ThalassemiaScreen());
                        }),
                  ],
                ),
                SizedBox(height: 8.h * 1.1),

                /// 🔹 About Us Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      minimumSize: Size(120.w * 1.1, 35.h * 1.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "About Us",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp * 1.1,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h * 1.1),

                /// 🔹 Blood Needed
                Text(
                  "Blood Needed",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp * 1.1,
                  ),
                ),
                SizedBox(height: 4.h * 1.1),
                Obx(
                      () => Wrap(
                    spacing: 4.w * 1.1,
                    children: controller.bloodTypes
                        .map((type) => BloodChip(type: type))
                        .toList(),
                  ),
                ),
                SizedBox(height: 12.h * 1.1),

                /// 🔹 Requests
                /// 🔹 Requests
                Text(
                  "Requests",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp * 1.1,
                  ),
                ),
                SizedBox(height: 4.h * 1.1),

                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.h),
                        child: CircularProgressIndicator(color: Colors.red[900]),
                      ),
                    );
                  }

                  if (controller.requests.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.h),
                        child: Text(
                          "No blood requests available right now.",
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp * 1.1),
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: controller.requests
                        .map(
                          (req) => RequestCard(
                            title: req["title"] ?? "Untitled",
                            name: req["pat_name"] ?? "Unknown",        // 👈 match API key
                            disease: req["disease"] ?? "Not specified",
                            bloodGroup: req["blood_group"] ?? "-",     // 👈 match API key
                            status: req["status"] ?? "Details",
                            onDetailsPressed: () {
                              Get.to(() => RequestedPostDetails());
                            },
                          )

                    )
                        .toList(),
                  );

                }),

                SizedBox(height: 60.h * 1.1), // nav bar space +10%
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Helper for Action Buttons
  Widget _actionButton(
      String text, Color color, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white, size: 16.sp * 1.1),
      label: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 11.sp * 1.1),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(120.w * 1.1, 40.h * 1.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }
}
