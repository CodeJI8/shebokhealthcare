import 'package:flutter/material.dart';

import 'DonationHistory.dart';


class DonationHistoryCard extends StatelessWidget {
  final DonationHistory donation;
  final VoidCallback? onRemove;

  const DonationHistoryCard({
    super.key,
    required this.donation,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(
          donation.patName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(donation.hospital ?? "Unknown Hospital"),
            Text(donation.phone),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: onRemove,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[100],
            foregroundColor: Colors.red[900],
          ),
          child: const Text("Remove"),
        ),
      ),
    );
  }
}
