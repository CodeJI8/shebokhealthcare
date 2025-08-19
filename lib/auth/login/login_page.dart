import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shebokhealthcare/auth/profile/profile_create_page.dart';
import '../signup/SignupPage.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.9; // 10% smaller for responsiveness

    return Scaffold(



      body: Stack(
        children: [

          const SizedBox(height: 20),
          // Solid red background
          Container(
            color: const Color(0xFFBD1F1C), // match Figma's red
          ),

          // Bottom-left yellow spot
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/spot.png',
              width: 200,
              fit: BoxFit.cover,
            ),
          ),

          // Top-right yellow spot
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/top_spot.png',
              width: 200,
              fit: BoxFit.cover,
            ),
          ),



          // Page content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Image.asset(
                      "assets/logo.png",
                      height: 100,
                    ),

                    const SizedBox(height: 20),

                    // White card container
                    Container(
                      width: cardWidth,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
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
                                  side: const BorderSide(color: Colors.red, width: 1),
                                  backgroundColor: Colors.red[900],
                                  foregroundColor: Colors.white, // text color
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                ),
                                child: const Text("Log In"),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton(
                                onPressed: () {
                                  Get.to(SignupPage());
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.red, width: 1),
                                  foregroundColor: Colors.black, // text color
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                ),
                                child: const Text("Sign Up"),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Email / Phone field
                          TextField(
                            onChanged: (value) =>
                            controller.emailOrPhone.value = value,
                            decoration: InputDecoration(
                              labelText: "Enter your email / phone",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width:1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width:1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Password field
                          Obx(() => TextField(
                            obscureText: !controller.isPasswordVisible.value,
                            onChanged: (value) =>
                            controller.password.value = value,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed:
                                controller.togglePasswordVisibility,
                              ),
                            ),
                          )),
                          const SizedBox(height: 16),

                          // Next button
                          ElevatedButton(
                            onPressed: (){
                              Get.to(ProfileCreatePage());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[900],
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            child: const Text(
                              "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
    );
  }
}
