import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/widgets/custom_button.dart';

class OpacityDoctorWelcomScreen extends StatelessWidget {
  final VoidCallback onClose;

  const OpacityDoctorWelcomScreen({super.key, required this.onClose});

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
              Text("Dr Scout",
                  style: GoogleFonts.crimsonText(
                      decoration: TextDecoration.none,
                      color: const Color(0xFFFFFFFF),
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 15,
              ),
              Image.asset("assets/images/dr_scout.png",scale: 5,),
              const SizedBox(
                height: 50,
              ),
              Text(
                " your smart guide to kidney care!  I’ll help you find the top kidney specialists near you — smart choices, just a tap away!",
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
              CustomButton(buttonText: "Find your doctor", onPressed: onClose),
            ],
          ),
        ),
      ),
    );
  }
}
