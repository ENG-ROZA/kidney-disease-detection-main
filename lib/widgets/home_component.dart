import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

Widget kidnyResultWidget(
  BuildContext context,
    {required String containerIcon,
    required Widget containerText,
    required double containerHeight,
    required double containerWidth}) {
  return Container(
      margin: const EdgeInsets.all(2.5),
      padding: const EdgeInsets.all(10.0),
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            width: 0.2,   color: const Color(0xFF2949C7).withOpacity(0.25),),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            containerIcon,
            height: 36,
            width: 36,
          ),
          const SizedBox(height: 2.5),
          containerText,
        ],
      ));
}

articlesWidget(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 200,
    decoration: BoxDecoration(
      color: Colors.teal,
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

Widget doctorhomeWidget(
  BuildContext context, {
  required String doctorImage,
  required String doctorName,
  required int rating,
  required String numberOfRating,
}) {
  return Container(
    padding: const EdgeInsets.all(5.0),
    width: 170,
    child: Stack(alignment: Alignment.bottomCenter, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(
          doctorImage,
          height: 200,
          width: 150,
          fit: BoxFit.cover,
        ),
      ),
      Container(
        alignment: Alignment.bottomLeft,
        width: 170,
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.elliptical(30, 30),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            border: Border.all(
               color: const Color(0xFF2949C7).withOpacity(0.25),
            )),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              doctorName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.merriweather(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1A4482),
                      Color(0xFF2F79E8),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                width: 40,
                height: 20,
                alignment: Alignment.center,
                child: Text(
                  "Details",
                  style: GoogleFonts.poppins(
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              SmoothStarRating(
                  rating: rating.toDouble(),
                  allowHalfRating: false,
                  starCount: 5,
                  size: 15.0,
                  color: const Color(0xFFFCB551),
                  borderColor: const Color(0xFFFCB551),
                  spacing: 0.0),
              const SizedBox(width: 5),
              Text(
                numberOfRating,
                style: GoogleFonts.crimsonText(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.87),
                ),
              ),
            ]),
          ]),
        ),
      ),
    ]),
  );
}
