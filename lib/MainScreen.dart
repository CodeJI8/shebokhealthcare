import 'package:flutter/material.dart';
import 'package:shebokhealthcare/ui/home/home.dart';
import 'package:shebokhealthcare/ui/profile/ProfileScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

// Main Screen: Holds the Bottom Navigation Bar
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Current index to track selected tab
  int _currentIndex = 0;

  // List of screens to display based on selected tab
  final List<Widget> _screens = [
    HomeScreen(),  // Home screen
    ProfileScreen(),  // Profile screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Example'),
      ),
      body: _screens[_currentIndex],  // Show the corresponding screen based on the current index

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,  // Current index for navigation
        onTap: (index) {
          setState(() {
            _currentIndex = index;  // Change the screen based on tab selection
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}