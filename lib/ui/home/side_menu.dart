// lib/widgets/side_menu.dart
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final void Function(String)? onItemSelected;

  const SideMenu({super.key, this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu, color: Colors.red),
      onPressed: () async {
        final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
        final button = context.findRenderObject() as RenderBox;
        final position = button.localToGlobal(Offset.zero, ancestor: overlay);

        final selected = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(
            position.dx,
            position.dy + button.size.height,
            position.dx + button.size.width,
            0,
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
            _menuItem("profile", "Profile"),

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
