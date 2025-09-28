import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shebokhealthcare/auth/kyc/KycVerificationPage.dart';
import 'package:shebokhealthcare/auth/login/login_page.dart';
import 'package:shebokhealthcare/auth/signup/SignupPage.dart';
import 'package:shebokhealthcare/ui/home/home.dart';

import 'MainScreen.dart';
import 'auth/create_profile/profile_create_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

  runApp(MyApp(initialRoute: token != null && token.isNotEmpty ? '/home' : '/login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignupPage()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/create_profile', page: () => ProfileCreatePage()),
        GetPage(name: '/main', page: () => MainScreen()),
        GetPage(name: '/kyc', page: () => KycVerificationPage()),
      ],
    );
  }
}

