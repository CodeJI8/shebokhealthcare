import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BloodChip extends StatefulWidget {
  final String type;
  final VoidCallback? onTap;
  final bool isSelected;

  const BloodChip({
    super.key,
    required this.type,
    this.onTap,
    this.isSelected = false,
  });

  @override
  State<BloodChip> createState() => _BloodChipState();
}

class _BloodChipState extends State<BloodChip> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap?.call(); // Call the onTap callback passed from parent (controller)
        setState(() {}); // Force a rebuild to show the selected state immediately
      },
      child: Chip(
        label: Text(
          widget.type,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: widget.isSelected ? Colors.white : Colors.red[900],
            fontSize: 8.sp, // Reduced font size for smaller chips
          ),
        ),
        backgroundColor: widget.isSelected ? Colors.red[900] : Colors.white,
        shape: StadiumBorder(
          side: BorderSide(
            color: Colors.red[900]!,
            width: 0.8.w,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h), // Reduced padding to make it smaller
      ),
    );
  }
}




