import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/layout/home_layout.dart';
import 'package:graduation_project/shared/utils/colors.dart';

void showLoading(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final screenHeight = mediaQuery.size.height;
  final screenWidth = mediaQuery.size.width;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Scanning in progress...",
                    style: TextStyle(color: primaryColor),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: screenHeight * 0.03,
                    height: screenHeight * 0.03,
                    child: const CircularProgressIndicator(color: primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

void showError(BuildContext context, String defaultErrorMessage) {
  final mediaQuery = MediaQuery.of(context);
  final screenHeight = mediaQuery.size.height;
  final screenWidth = mediaQuery.size.width;

  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.05),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: const Color(0xFFFF3B30),
                    size: screenHeight * 0.03,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    "ERROR",
                    style: TextStyle(
                      fontSize: screenHeight * 0.025,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF3B30),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                defaultErrorMessage,
                style: GoogleFonts.merriweather(
                  fontSize: screenHeight * 0.022,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFFF3B30),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.022,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void warningDialog(
  BuildContext context,
  String message,
  String redButtonText,
  VoidCallback redButtonFunction,
) {
  final mediaQuery = MediaQuery.of(context);
  final screenHeight = mediaQuery.size.height;
  final screenWidth = mediaQuery.size.width;

  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        shadowColor: Colors.black.withOpacity(0.75),
        elevation: 0,
        backgroundColor: Colors.white,
        insetAnimationCurve: Curves.decelerate,
        insetAnimationDuration: const Duration(milliseconds: 1000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: screenHeight * 0.3,
              width: screenWidth * 0.8,
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Warning",
                        style: TextStyle(
                          fontSize: screenHeight * 0.025,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Icon(
                        Icons.warning,
                        color: const Color(0xFFFF3B30),
                        size: screenHeight * 0.025,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.merriweather(
                      fontSize: screenHeight * 0.022,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFDADADA),
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.03),
                            ),
                            alignment: Alignment.center,
                            height: screenHeight * 0.06,
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.merriweather(
                                fontSize: screenHeight * 0.02,
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: GestureDetector(
                          onTap: redButtonFunction,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF3B30),
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.03),
                            ),
                            alignment: Alignment.center,
                            height: screenHeight * 0.06,
                            child: Text(
                              redButtonText,
                              style: GoogleFonts.merriweather(
                                fontSize: screenHeight * 0.022,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

void showSuccessDialog(BuildContext context, String message) {
  final mediaQuery = MediaQuery.of(context);
  final screenHeight = mediaQuery.size.height;
  final screenWidth = mediaQuery.size.width;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: primaryColor,
              size: screenHeight * 0.025,
            ),
            SizedBox(width: screenWidth * 0.02),
            Text(
              "Success",
              style: TextStyle(
                fontSize: screenHeight * 0.025,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: GoogleFonts.merriweather(
            fontSize: screenHeight * 0.022,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.015,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeLayout(),
                ),
                (route) => false,
              );
            },
            child: Text(
              "Finish",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.022,
              ),
            ),
          ),
        ],
      );
    },
  );
}

void showLoadingDialog(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final screenHeight = mediaQuery.size.height;
  final screenWidth = mediaQuery.size.width;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: screenHeight * 0.03,
                height: screenHeight * 0.03,
                child: const CircularProgressIndicator(color: primaryColor),
              ),
              SizedBox(width: screenWidth * 0.03),
              Text(
                "Loading...",
                style: TextStyle(color: primaryColor, fontSize: screenHeight * 0.022),
              ),
            ],
          ),
        ),
      );
    },
  );
}