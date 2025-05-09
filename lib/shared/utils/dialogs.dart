import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/layout/home_layout.dart';
import 'package:graduation_project/shared/utils/colors.dart';

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Scanning in progress...",
                    style: TextStyle(color: primaryColor),
                  ),
                  Spacer(),
                  CircularProgressIndicator(
                    color: primaryColor,
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
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFFFF3B30),
                    size: 26.5,
                  ),
                  SizedBox(width: 8.5),
                  Text(
                    "ERROR",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF3B30),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(defaultErrorMessage,
                  style: GoogleFonts.merriweather(
                      fontSize: 18, color: Colors.black.withOpacity(0.5))),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFFF3B30),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
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

void warningDialog(BuildContext context, String message, String redButtonText,
    VoidCallback redButtonFunction) {
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
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          height: 230,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Warning",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.warning,
                    color: Color(0xFFFF3B30),
                    size: 25,
                  ),
                ],
              ),
              const SizedBox(height: 27.0),
              Text(message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.merriweather(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              Row(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFDADADA),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      width: 130,
                      height: 50,
                      child: Text("Cancel",
                          style: GoogleFonts.merriweather(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold))),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    redButtonFunction();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF3B30),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    alignment: Alignment.center,
                    width: 130,
                    height: 50,
                    child: Text(redButtonText,
                        style: GoogleFonts.merriweather(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ])
            ],
          ),
        ),
      );
    },
  );
}

void showSuccessDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Row(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: primaryColor,
              size: 26.5,
            ),
            SizedBox(width: 8.5),
            Text(
              "Success",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: GoogleFonts.merriweather(
            fontSize: 18,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
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
            child: const Text(
              "Finish",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    },
  );
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: primaryColor),
              SizedBox(width: 16),
              Text("Loading...", style: TextStyle(color: primaryColor)),
            ],
          ),
        ),
      );
    },
  );
}
