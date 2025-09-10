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
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w), // smaller
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(10.w), // reduced padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Requested Title",
              style: TextStyle(color: Colors.grey, fontSize: 11.sp),
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp, // reduced
              ),
            ),
            SizedBox(height: 4.h),
            Text(name, style: TextStyle(fontSize: 11.sp)),
            Text(
              disease,
              style: TextStyle(fontSize: 11.sp, color: Colors.black87),
            ),
            SizedBox(height: 8.h),

            // 🔹 Blood Group + Button in One Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  bloodGroup,
                  style: TextStyle(
                    fontSize: 15.sp, // reduced from 18
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    status == "Success" ? Colors.green : Colors.green[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w, // smaller padding
                      vertical: 6.h,
                    ),
                  ),
                  onPressed: onDetailsPressed,
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: status == "Success"
                          ? Colors.white
                          : Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
