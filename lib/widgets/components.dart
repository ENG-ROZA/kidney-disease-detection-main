import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

Widget headTitlesOfTextField(String name) {
  return Text(
    name,
    textAlign: TextAlign.start,
    style: GoogleFonts.merriweather(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF000000)),
  );
}

Widget rateWidget(
    {required double rate, required Function(double) onRatingChangedMethod}) {
  return SmoothStarRating(
      allowHalfRating: false,
      rating: rate,
      onRatingChanged: onRatingChangedMethod,
      starCount: 5,
      size: 20.0,
      filledIconData: Icons.blur_off,
      halfFilledIconData: Icons.blur_on,
      color: const Color(0xFFFCB551),
      borderColor: const Color(0xFFFCB551),
      spacing: 0.0);
}

Widget authButtonLoadingWidget() {
  return SizedBox(
    height: 57,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      child: const Center(
        child: CircularProgressIndicator(
            strokeCap: StrokeCap.round, strokeWidth: 6, color: Colors.white),
      ),
    ),
  );
}
