import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for Clipboard

void showReferralCodePopup(BuildContext context, String referralCode) {
  showDialog(
    context: context,
    barrierDismissible: true, // tap outside to close
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Title
            Text(
              "Referral Code",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),

            /// Subtitle
            Text(
              '"Copy Your 6-Digit Referral Code Below To Get Rewards!"',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 15),

            /// Referral Code Digits
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: referralCode
                  .split("")
                  .map((digit) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  digit,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900],
                  ),
                ),
              ))
                  .toList(),
            ),
            SizedBox(height: 20),

            /// Copy Button
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: referralCode));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Referral code copied!")),
                );
                Navigator.pop(context); // close popup after copy
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[900],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Copy", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      );
    },
  );
}
