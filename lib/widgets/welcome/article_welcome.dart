import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/widgets/custom_button.dart';

class OpacityArticleWelcomScreen extends StatelessWidget {
  final VoidCallback onClose;

  const OpacityArticleWelcomScreen({super.key, required this.onClose});

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
              Text("Dr Wisely",
                  style: GoogleFonts.crimsonText(
                      decoration: TextDecoration.none,
                      color: const Color(0xFFFFFFFF),
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 15,
              ),
              Image.asset("assets/images/dr_wisely.png",scale: 5,),
              const SizedBox(
                height: 50,
              ),
              Text(
                " I’m here to keep you updated with the latest articles and news about kidney health, so you’re always in the know.",
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
              CustomButton(buttonText: "View articles", onPressed: onClose),
            ],
          ),
        ),
      ),
    );
  }
}
