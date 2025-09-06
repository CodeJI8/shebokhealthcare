import 'package:flutter/material.dart';

class AreaFilterCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String hospital;
  final int rating;
  final String image;

  const AreaFilterCard({
    Key? key,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.rating,
    required this.image,
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
              backgroundImage: NetworkImage(image),
              radius: 24,
            ),
            const SizedBox(width: 12),

            // Info Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      if (specialty.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Text(specialty,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.green)),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(hospital,
                      style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),

            // Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 16),
                Text(" $rating Rating",
                    style: const TextStyle(fontSize: 12)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
