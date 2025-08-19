import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shebokhealthcare/auth/login/login_page.dart';
import 'package:shebokhealthcare/auth/profile/profile_create_page.dart';
import 'package:shebokhealthcare/auth/signup/SignupPage.dart';
import 'package:shebokhealthcare/ui/home/home.dart';

import 'MainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignupPage()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/profile', page: () => ProfileCreatePage()),
        GetPage(name: '/main', page: () => MainScreen()), // 🔹 New parent page
      ],
    );
  }
}

