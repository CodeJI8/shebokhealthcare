import 'package:flutter/material.dart';

class AreaFilterCard extends StatelessWidget {
  final String name;
  final String phone;
  final String address;
  final String? image;
  final double? distanceKm;

  const AreaFilterCard({
    Key? key,
    required this.name,
    required this.phone,
    required this.address,
    this.image,
    this.distanceKm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            CircleAvatar(
              backgroundImage: image != null && image!.isNotEmpty
                  ? NetworkImage(image!)
                  : const AssetImage("assets/images/placeholder.png")
              as ImageProvider,
              radius: 24,
            ),
            const SizedBox(width: 12),

            // Info Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    phone,
                    style: const TextStyle(color: Colors.green, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  if (distanceKm != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      "📍 ${distanceKm!.toStringAsFixed(2)} km away",
                      style: const TextStyle(
                          fontSize: 12, color: Colors.blueGrey),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
