import 'package:flutter/material.dart';
import 'package:shebokhealthcare/ui/home/home.dart';
import 'package:shebokhealthcare/ui/profile/ProfileScreen.dart';
import 'package:shebokhealthcare/ui/widgets/BottomNav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final _pages = [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNav(
          currentIndex: _currentIndex,
          onTabSelected: (index) {
            setState(() => _currentIndex = index);
          },
        ),
      ),
    );
  }
}
