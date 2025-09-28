import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Container(
      // Make the card responsive to screen size
      width: MediaQuery.of(context).size.width * 0.9,  // Adjust width to be 90% of screen width
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w), // Padding for card
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 6.h), // smaller margin
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), // no radius
        elevation: 0,  // no elevation
        child: Padding(
          padding: EdgeInsets.all(10.w), // reduced padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp, // reduced font size
                ),
                overflow: TextOverflow.ellipsis, // Prevent overflow
                maxLines: 1, // Limit to 1 line
              ),
              SizedBox(height: 4.h),
              Text(
                name,
                style: TextStyle(fontSize: 11.sp),
                overflow: TextOverflow.ellipsis, // Prevent overflow
                maxLines: 1, // Limit to 1 line
              ),
              Text(
                disease,
                style: TextStyle(fontSize: 11.sp, color: Colors.black87),
                overflow: TextOverflow.ellipsis, // Prevent overflow
                maxLines: 1, // Limit to 1 line
              ),
              SizedBox(height: 8.h),

              // 🔹 Blood Group + Button in One Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      bloodGroup,
                      style: TextStyle(
                        fontSize: 15.sp, // reduced from 18
                        fontWeight: FontWeight.bold,
                        color: Colors.red[900],
                      ),
                      overflow: TextOverflow.ellipsis, // Prevent overflow
                      maxLines: 1, // Limit to 1 line
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // White background
                      side: BorderSide(
                        color: Colors.green, // Green outline
                        width: 1, // Thickness of the border
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w, // smaller padding
                        vertical: 6.h,
                      ),
                      minimumSize: Size(70.w, 20.h),
                    ),
                    onPressed: onDetailsPressed,
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.black, // Black text
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
