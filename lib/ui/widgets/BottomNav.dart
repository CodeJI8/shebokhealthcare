import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  // Function to open the phone dialer
  void _openDialer() async {
    const phoneNumber = 'tel:1234567890'; // Replace with your phone number
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not open dialer';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get the screen width and make the bottom nav responsive
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = screenWidth * 0.1; // Dynamic padding based on screen width

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: 20,
          left: padding,  // Responsive padding
          right: padding, // Responsive padding
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            width: screenWidth - 2 * padding,  // Adjust width dynamically
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 9),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navItem(Icons.home, "Home", 0),
                _navItem(Icons.person, "Profile", 1),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: _openDialer,  // Call the _openDialer function
              customBorder: const CircleBorder(),
              splashColor: Colors.red.withOpacity(0.2),
              highlightColor: Colors.red.withOpacity(0.1),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(Icons.phone, color: Colors.black, size: 28),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    bool isSelected = index == currentIndex;

    return InkWell(
      onTap: () => onTabSelected(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[300],
              size: isSelected ? 24 : 20,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[300],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
