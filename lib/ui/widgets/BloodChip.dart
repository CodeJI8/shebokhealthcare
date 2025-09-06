import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BloodChip extends StatelessWidget {
  final String type;
  final VoidCallback? onTap;

  const BloodChip({super.key, required this.type, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(
          type,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red[900],
            fontSize: 11.sp, // reduced ~20%
          ),
        ),
        shape: StadiumBorder(
          side: BorderSide(
            color: Colors.red[900]!,
            width: 0.8.w, // thinner border
          ),
        ),
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 6.w, // smaller padding
          vertical: 2.h,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // tighter fit
      ),
    );
  }
}
