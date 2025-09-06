import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shebokhealthcare/auth/login/login_page.dart';
import 'signup_controller.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.9; // 10% smaller for responsiveness

    return Scaffold(
      body: Stack(
        children: [
          // Solid red background
          Container(color: const Color(0xFFBD1F1C)),

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
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Image.asset(
                      "assets/logo.png",
                      height: 100,
                    ),
                    const SizedBox(height: 20),

                    // Card Container
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
                                onPressed: () {
                                  Get.to(LoginPage());
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.red, width: 1.5),
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                ),
                                child: const Text("Log In"),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.red, width: 1.5),
                                  backgroundColor: Colors.red[900],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                ),
                                child: const Text("Sign Up"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Full Name
                          TextField(
                            onChanged: (value) =>
                            controller.fullName.value = value,
                            decoration: _inputDecoration("Full name"),
                          ),
                          const SizedBox(height: 12),

                          // Phone
                          TextField(
                            onChanged: (value) =>
                            controller.Phone.value = value,
                            decoration: _inputDecoration("Enter your Phone"),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 12),

                          // Password
                          Obx(() => TextField(
                            obscureText:
                            !controller.isPasswordVisible.value,
                            onChanged: (value) =>
                            controller.password.value = value,
                            decoration: _inputDecoration(
                              "Password",
                              suffixIcon: IconButton(
                                icon: Icon(controller
                                    .isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed:
                                controller.togglePasswordVisibility,
                              ),
                            ),
                          )),
                          const SizedBox(height: 12),

                          // Confirm Password
                          Obx(() => TextField(
                            obscureText: !controller
                                .isConfirmPasswordVisible.value,
                            onChanged: (value) => controller
                                .confirmPassword.value = value,
                            decoration: _inputDecoration(
                              "Confirm password",
                              suffixIcon: IconButton(
                                icon: Icon(controller
                                    .isConfirmPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: controller
                                    .toggleConfirmPasswordVisibility,
                              ),
                            ),
                          )),
                          const SizedBox(height: 12),

                          // Referral Code
                          TextField(
                            onChanged: (value) =>
                            controller.referralCode.value = value,
                            decoration: _inputDecoration("Referral code (optional)"),
                          ),
                          const SizedBox(height: 16),

                          // Next Button
                          ElevatedButton(
                            onPressed: controller.signup,
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

  InputDecoration _inputDecoration(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width:1),
      ),
      suffixIcon: suffixIcon,
    );
  }
}
