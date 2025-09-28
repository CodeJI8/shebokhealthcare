// lib/widgets/side_menu.dart
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final void Function(String)? onItemSelected;

  const SideMenu({super.key, this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        width: 25, // Width of the button (adjust as needed)
        height: 25, // Height of the button (adjust as needed)
        decoration: BoxDecoration(
          color: Colors.red[900], // Red background
          borderRadius: BorderRadius.circular(5), // Apply 5px circular radius
        ),
        child: Icon(
          Icons.menu,
          color: Colors.white, // White icon
          size: 18, // Reduce icon size (adjust as needed)
        ),
      ),

      onPressed: () async {
        final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
        final button = context.findRenderObject() as RenderBox;
        final position = button.localToGlobal(Offset.zero, ancestor: overlay);

        final selected = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(
            0, // Position the menu at the left side of the screen
            position.dy + button.size.height, // Position it below the button
            0, // No right offset, keeping the menu fixed on the left side
            0, // No bottom offset
          ),
          items: [
            // 🔹 Logo Header
            PopupMenuItem<String>(
              enabled: false,
              child: Column(
                children: [
                  Image.asset("assets/menu_blood_ic.png", height: 60),
                  Text(
                    "BLOOD DONATION",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),

            // 🔹 Menu Items
            _menuItem("hospital", "Affiliated Hospital"),
            _menuItem("refer", "Refer Others"),
            _menuItem("post", "My Post"),
            _menuItem("donationHistory", "Donation History"),
            _menuItem("foreignTreatment", "Foreign Treatment"),
            _menuItem("booking", "Online Booking"),
            _menuItem("appointments", "My Appointments"),
            _menuItem("settings", "Settings"),
            _menuItem("create_profile", "Profile"),

            // 🔹 Divider + Logout
            const PopupMenuDivider(),
            PopupMenuItem<String>(
              value: 'logout',
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 8),
                  Text("Log Out"),
                ],
              ),
            ),
          ],
        );

        if (selected != null && onItemSelected != null) {
          onItemSelected!(selected);
        }
      },
    );

  }

  /// 🔹 Helper for items
  PopupMenuItem<String> _menuItem(String value, String text) {
    return PopupMenuItem<String>(
      value: value,
      child: Text(text, style: TextStyle(color: Colors.black)),
    );
  }
}
