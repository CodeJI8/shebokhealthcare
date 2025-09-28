// doctor_card.dart
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final int doctorId; // 👈 new
  final String name;
  final String specialty;
  final String education;
  final String experience;
  final String fee;
  final String? image;
  final VoidCallback onBook;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.education,
    required this.experience,
    required this.fee,
    this.image,
    required this.onBook, required this.doctorId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section: profile + info
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: (image != null && image!.isNotEmpty)
                      ? NetworkImage(image!)
                      : const AssetImage("assets/doctor_placeholder.png")
                  as ImageProvider,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        specialty,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        education,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.work, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            "$experience yrs experience",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.attach_money,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 2),
                          Text(
                            "৳$fee",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Book Appointment button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.calendar_today, color: Colors.white, size: 16),
                label: const Text(
                  "Book Appointment",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                onPressed: onBook,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
