import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ✅ for responsiveness
import 'package:shebokhealthcare/auth/profile/profile_create_page.dart';
import '../signup/SignupPage.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.9; // keep card slightly smaller

    return ScreenUtilInit(
      designSize: const Size(390, 844), // base design size
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
                width: 200.w * 0.9, // -10%
                fit: BoxFit.cover,
              ),
            ),

            // Top-right spot
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/top_spot.png',
                width: 200.w * 0.9, // -10%
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            // Tabs
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.red, width: 1),
                                    backgroundColor: Colors.red[900],
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.w * 0.9,
                                      vertical: 12.h * 0.9,
                                    ),
                                  ),
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(fontSize: 14.sp * 0.9),
                                  ),
                                ),
                                SizedBox(width: 8.w * 0.9),
                                OutlinedButton(
                                  onPressed: () {
                                    Get.to(SignupPage());
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.red, width: 1),
                                    foregroundColor: Colors.black,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.w * 0.9,
                                      vertical: 12.h * 0.9,
                                    ),
                                  ),
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(fontSize: 14.sp * 0.9),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h * 0.9),

                            // Phone field
                            TextField(
                              controller: controller.phoneController,
                              decoration: InputDecoration(
                                labelText: "Enter phone",
                                labelStyle:
                                TextStyle(fontSize: 13.sp * 0.9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: Colors.red[900]!,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: Colors.red[900]!,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: Colors.red[900]!,
                                    width: 2,
                                  ),
                                ),
                              ),
                              style: TextStyle(fontSize: 13.sp * 0.9),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 12.h * 0.9),

                            // Password field
                            Obx(() => TextField(
                              controller: controller.passwordController,
                              obscureText:
                              !controller.isPasswordVisible.value,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle:
                                TextStyle(fontSize: 13.sp * 0.9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: Colors.red[900]!,
                                    width: 1.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: Colors.red[900]!,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: Colors.red[900]!,
                                    width: 2,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 18.sp * 0.9,
                                  ),
                                  onPressed:
                                  controller.togglePasswordVisibility,
                                ),
                              ),
                              style: TextStyle(fontSize: 13.sp * 0.9),
                            )),
                            SizedBox(height: 16.h * 0.9),

                            // Remember Me checkbox
                            Obx(() => CheckboxListTile(
                              value: controller.isrememberme.value,
                              onChanged: controller.toggleRememberMe,
                              title: Text(
                                "Remember Me",
                                style: TextStyle(fontSize: 13.sp * 0.9),
                              ),
                              controlAffinity:
                              ListTileControlAffinity.leading,
                              activeColor: Colors.red[900],
                            )),
                            SizedBox(height: 16.h * 0.9),

                            // Login button
                            Obx(() => ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : controller.login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[900],
                                minimumSize: Size(
                                    double.infinity, 48.h * 0.9), // -10%
                              ),
                              child: controller.isLoading.value
                                  ? SizedBox(
                                height: 20.h * 0.9,
                                width: 20.h * 0.9,
                                child:
                                const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                                  : Text(
                                "Login",
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
}
