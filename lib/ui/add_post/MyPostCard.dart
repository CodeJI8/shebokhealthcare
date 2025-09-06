import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_post_controller.dart';

class MyPostCard extends StatelessWidget {
  final int index;
  final Post post;
  final MyPostController controller;

  const MyPostCard({
    Key? key,
    required this.index,
    required this.post,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Blood Group Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Requested Title",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    post.bloodGroup,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Text(post.hospitalName,
                style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(post.patientName),
            Text(post.disease),

            const SizedBox(height: 16),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Delete Button
                ElevatedButton(
                  onPressed: () => controller.showDeleteDialog(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Delete",
                      style: TextStyle(color: Colors.white)),
                ),

                // Update Button
                OutlinedButton(
                  onPressed: () {
                    controller.updatePost(
                      index,
                      Post(
                        hospitalName: post.hospitalName,
                        patientName: post.patientName,
                        disease: post.disease,
                        bloodGroup: post.bloodGroup,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.green, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Update",
                      style: TextStyle(color: Colors.green)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
