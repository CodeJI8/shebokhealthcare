import 'package:flutter/material.dart';

class BloodChip extends StatelessWidget {
  final String type;
  final VoidCallback? onTap;

  const BloodChip({super.key, required this.type, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(type,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.red)),
        shape: StadiumBorder(side: BorderSide(color: Colors.red)),
        backgroundColor: Colors.white,
      ),
    );
  }
}
