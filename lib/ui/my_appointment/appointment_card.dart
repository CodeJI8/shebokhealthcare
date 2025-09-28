import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentCard extends StatelessWidget {
  final int doctorId;
  final String name;
  final String specialty;
  final String date;
  final String time;
  final String status;
  final String? image;
  final String? meetLink; // New field for meeting link

  const AppointmentCard({
    super.key,
    required this.doctorId,
    required this.name,
    required this.specialty,
    required this.date,
    required this.time,
    required this.status,
    this.image,
    this.meetLink, // Initialize meetLink
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "approved":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top: doctor avatar + info
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
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
                      Text(name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(
                        specialty,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Appointment details
            Row(
              children: [
                const Icon(Icons.date_range, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text("Date: $date",
                    style: const TextStyle(fontSize: 13, color: Colors.black87)),
              ],
            ),

            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text("Time: $time",
                    style: const TextStyle(fontSize: 13, color: Colors.black87)),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to prescription page or trigger any functionality
                    // controller.prescription();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(50, 25),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    "Prescription",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),


            Row(
              children: [
                const Icon(Icons.desktop_mac, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  "Meetlink: $meetLink",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  color: Colors.black
                  ),
                ),


              ],
            ),

            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.verified, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  "Status: $status",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(status),
                  ),
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to launch the meet link
  void _launchURL(String url) {
    // Use url_launcher package to open URL
    launch(url);
  }
}
