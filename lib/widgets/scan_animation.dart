import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:lottie/lottie.dart';

Future progressDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shadowColor: Colors.black.withOpacity(0.75),
          elevation: 0,
          backgroundColor: Colors.white,
          insetAnimationCurve: Curves.decelerate,
          insetAnimationDuration: const Duration(milliseconds: 1000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Lottie.asset(
                      'assets/animations/scan_image_animation.json',
                      repeat: true),
                ),
                const LinearProgressIndicator(
                  color: primaryColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'Scanning in progress...\nPlease wait a moment',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: const Color(0xFF2b3151)),
                ),
              ],
            ),
          ),
        );
      });
}
