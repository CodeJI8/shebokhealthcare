import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // ⬅️ Add this
import '../home/home.dart';
import '../profile/ProfileScreen.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: 40,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            height: 60,
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navItem(Icons.home, "Home", 0),
                SizedBox(width: 50),
                _navItem(Icons.person, "Profile", 1),
              ],
            ),
          ),
        ),
// Floating Call Button with ripple effect
        Positioned(
          bottom: 40,
          child: Material(
            color: Colors.transparent, // No background so only the button shows
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () => _launchDialer('1234567890'),
              customBorder: const CircleBorder(),
              splashColor: Colors.red.withOpacity(0.2), // Ripple color
              highlightColor: Colors.red.withOpacity(0.1), // Tap highlight
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(Icons.phone, color: Colors.red, size: 28),
              ),
            ),
          ),
        )

      ],
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    bool isSelected = index == currentIndex;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onTabSelected(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
              size: isSelected ? 24 : 20,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      Get.snackbar('Error', 'Could not launch dialer');
    }
  }
}


