import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String branch;
  final String phone;

  const HospitalCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.branch,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,  // Set border radius to zero
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(imagePath),
          backgroundColor: Colors.grey.shade200,
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(branch, style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Text(
              phone,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ],
        ),
        onTap: () {
          // You can navigate to hospital details page here
        },
      ),
    );
  }
}
