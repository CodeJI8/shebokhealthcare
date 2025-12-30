import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shebokhealthcare/ui/donation_history/DonationHistoryPage.dart';
import 'package:shebokhealthcare/ui/find_doctors/find_doctor_screen.dart';
import 'package:shebokhealthcare/ui/home/side_menu.dart';
import 'package:shebokhealthcare/ui/online/doctor_list_screen.dart';
import 'package:shebokhealthcare/ui/profile/ProfileScreen.dart';
import 'package:shebokhealthcare/ui/thalassemia/thalassemia_screen.dart';
import '../../auth/create_profile/profile_create_page.dart';
import '../AboutPage.dart';
import '../affiliated/HospitalListScreen.dart';
import '../foreign/foreign_treatment_screen.dart';
import '../my_appointment/MyAppointmentsScreen.dart';
import '../mypost/my_post_screen.dart';
import '../post/requested_post_details.dart';
import '../request_blood/BloodRequestScreen.dart';
import '../widgets/BloodChip.dart';
import 'RequestCard.dart';
import '../widgets/showReferralCodePopup.dart';
import 'home_controller.dart';
import '../widgets/BottomNav.dart'; // Import BottomNav

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  int _currentIndex = 0; // Add state to manage bottom nav index
  final ScrollController _scrollController = ScrollController(); // Scroll controller for pagination

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.white,

        body: Scaffold(


          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          extendBody: false,
          body:
            SafeArea(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.fromLTRB(12.w * 1.1, 12.w * 1.1, 12.w * 1.1, 100.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 🔹 Top Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/logo.png",
                          height: 61.h,
                          width: 61.w, // +10%
                          color: Colors.red[900],
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[900],
                                minimumSize: Size(47.w, 28.h),
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

                                  case 'refer':
                                    showReferralCodePopup(context, "161016");
                                    break;

                                  case 'post':
                                    Get.to(() => MyPostScreen());
                                    break;

                                  case 'donationHistory':
                                    Get.to(() => DonationHistoryPage());
                                    break;

                                  case 'foreignTreatment':
                                    Get.to(() => ForeignTreatmentScreen());
                                    break;

                                  case 'booking':
                                    Get.to(() => DoctorListScreen());
                                    break;

                                  case 'appointments':
                                    Get.to(() => MyAppointmentsScreen());
                                    break;

                                  case 'create_profile':
                                    Get.to(() => ProfileScreen());
                                    break;

                                  case 'logout':
                                    final shouldLogout = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
                                      title: const Text("Logout"),
                                      content: const Text("Are you sure you want to log out?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(ctx).pop(false),
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.of(ctx).pop(true),
                                          child: const Text("Logout"),
                                        ),
                                      ],
                                    ));
                                    if (shouldLogout == true) {
                                      final prefs = await SharedPreferences.getInstance();
                                      await prefs.clear();
                                      Get.offAllNamed("/login");
                                    }
                                    break;
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h * 1.1),

                    Obx(() {
                      if (controller.sliders.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.red[900],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "No Sliders Available",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }
                      return Container(
                        width: 500, // Set the width to 350
                        height: 170, // Set the height to 150
                        child: CarouselSlider(
                          options: CarouselOptions(

                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.easeInOut,
                            enlargeCenterPage: true,
                            viewportFraction: 0.9,
                          ),
                          items: controller.sliders.map((slider) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: 350,  // Set width to 350
                                height: 150, // Set height to 150
                                child: Image.network(
                                  slider["image_url"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );

                          }).toList(),
                        ),
                      );
                    }),


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

                    Column(
                      children: [
                        // First Row: Add A Post & Become A Donor
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => BloodRequestScreen());
                                },
                                child: Container(
                                  height: 75.0, // Fixed height
                                  decoration: BoxDecoration(
                                    color: Colors.red[900]!,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add, color: Colors.white, size: 16.sp * 1.1),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Add A Post",
                                        style: TextStyle(color: Colors.white, fontSize: 11.sp * 1.1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w), // Space between buttons
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ProfileCreatePage());
                                },
                                child: Container(
                                  width: 342,
                                  height: 75.0, // Fixed height
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1CBD31), // Custom green color
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.volunteer_activism, color: Colors.white, size: 16.sp * 1.1),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Become A Donor",
                                        style: TextStyle(color: Colors.white, fontSize: 11.sp * 1.1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h), // Spacing between rows

                        // Second Row: Online Booking & Foreign Treatment
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => DoctorListScreen());
                                },
                                child: Container(
                                  width: 342,
                                  height: 75.0,  // Smaller height
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE1B209), // Custom yellow color
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.book_online, color: Colors.white, size: 16.sp * 1.1),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Online Booking",
                                        style: TextStyle(color: Colors.white, fontSize: 11.sp * 1.1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w), // Space between buttons
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ForeignTreatmentScreen());
                                },
                                child: Container(
                                  width: 342,
                                  height: 75.0,// Smaller height
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1C31BD), // Custom blue color
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.public, color: Colors.white, size: 16.sp * 1.1),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Foreign Treatment",
                                        style: TextStyle(color: Colors.white, fontSize: 11.sp * 1.1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h), // Spacing between rows

                        // Third Row: Find Doctors & Thalassemia Club
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => FindDoctorScreen());
                                },
                                child: Container(
                                  width: 162,
                                  height: 28,  // Smaller height
                                  decoration: BoxDecoration(
                                    color: Color(0xFF10C88B), // Custom green color
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      SizedBox(width: 8.w),
                                      Text(
                                        "Find Doctors",
                                        style: TextStyle(color: Colors.white, fontSize: 11.sp ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w), // Space between buttons
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ThalassemiaScreen());
                                },
                                child: Container(
                                  width: 162,
                                  height: 28, // Smaller height
                                  decoration: BoxDecoration(
                                    color: Color(0xFF6FBA0D), // Custom green color
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Text(
                                        "Thalassemia Club",
                                        style: TextStyle(color: Colors.white, fontSize: 11.sp ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),


                    SizedBox(height: 8.h),

                    // 🔹 About Us Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(AboutPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[600],
                          minimumSize: Size(342.w * 1.1, 28.h * 1.1),
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
                    SizedBox(height: 8.h),

                    // 🔹 Blood Needed
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 7.0),
                        child: Text(
                          "Blood Needed",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp * 1.1,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(controller.bloodTypes.length, (index) {
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: BloodChip(
                                type: controller.bloodTypes[index],
                                isSelected: controller.selectedBloodType.value == controller.bloodTypes[index],
                                onTap: () => controller.selectBloodType(controller.bloodTypes[index]),
                              ),
                            ),
                          );
                        }),
                      );
                    }),








                    SizedBox(height: 12.h * 1.1),

                    Obx(() => Padding(
                      padding: EdgeInsets.only(left: 7.0), // 7px padding from the left
                      child: SwitchListTile(
                        title: Text(
                          "Nearby",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: controller.isNearbyOn.value,
                        onChanged: (bool value) {
                          controller.toggleNearby(value); // Toggle nearby feature
                        },
                        activeColor: Colors.red[900], // Set active color to red
                        contentPadding: EdgeInsets.zero, // Remove any extra padding
                      ),
                    )),

                    SizedBox(height: 12.h * 1.1),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 7.0),  // Adjust the value as needed
                        child: Text(
                          "Requests",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp * 1.1,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 4.h * 1.1),

                    Obx(() {
                      if (controller.isLoading.value) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.h),
                            child: CircularProgressIndicator(
                              color: Colors.red[900],
                            ),
                          ),
                        );
                      }

                      final requests = controller.filteredRequests;

                      if (requests.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.h),
                            child: Text(
                              controller.selectedBloodType.value.isEmpty
                                  ? "No blood requests available right now."
                                  : "No requests found for ${controller.selectedBloodType.value}.",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.sp * 1.1,
                              ),
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true, // Ensures the ListView doesn't take up unnecessary space
                        physics: NeverScrollableScrollPhysics(), // Prevents the ListView from being scrollable independently
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          final req = requests[index];
                          return RequestCard(
                            title: req["title"] ?? "Untitled",
                            name: req["pat_name"] ?? "Unknown",
                            disease: req["disease"] ?? "Not specified",
                            bloodGroup: req["blood_group"] ?? "-",
                            status: req["status"] ?? "Details",
                            onDetailsPressed: () {
                              Get.to(() => RequestedPostDetails(), arguments: req);
                            },
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
        ),


        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Center the floating action button
        floatingActionButton: BottomNav(
          currentIndex: _currentIndex,
          onTabSelected: (index) {
            setState(() {
              _currentIndex = index;
            });

            // Switch the screen based on the selected index
            switch (index) {
              case 0:
                break;
              case 1:
                Get.to(() => ProfileScreen());
                break;
            }
          },
        ),
      ),
    );
  }




}
