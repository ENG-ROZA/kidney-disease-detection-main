import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/widgets/custom_button.dart';

class OpacityWelcomScreen extends StatelessWidget {
  final VoidCallback onClose;

  const OpacityWelcomScreen({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.78),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Dr Reni",
                  style: GoogleFonts.crimsonText(
                      decoration: TextDecoration.none,
                      color: const Color(0xFFFFFFFF),
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 10,
              ),
              Image.asset("assets/images/dr_reni.png"),
              const SizedBox(
                height: 50,
              ),
              Text(
                "your friendly kidney health assistant!Upload your scan or test result,and I’ll help you find out if you have a tumor, a stone, a cystic kidney, or if everything looks perfectly healthy!",
                style: GoogleFonts.crimsonText(
                    decoration: TextDecoration.none,
                    color: const Color(0xFFFFFFFF),
                    fontSize: 25,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 80,
              ),
              CustomButton(buttonText: "Go to upload", onPressed: onClose),
            ],
          ),
        ),
      ),
    );
  }
}
