import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  final String title;
  final String name;
  final String disease;
  final String bloodGroup;
  final String status;
  final VoidCallback? onDetailsPressed;

  const RequestCard({
    super.key,
    required this.title,
    required this.name,
    required this.disease,
    required this.bloodGroup,
    required this.status,
    this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Requested Title", style: TextStyle(color: Colors.grey)),
            Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 4),
            Text(name),
            Text(disease),
            SizedBox(height: 6),

            // 🔹 Added Blood Group Row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  bloodGroup,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: status == "Success"
                      ? Colors.green
                      : Colors.grey.shade300,
                ),
                onPressed: onDetailsPressed,
                child: Text(
                  status,
                  style: TextStyle(
                    color: status == "Success" ? Colors.white : Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
