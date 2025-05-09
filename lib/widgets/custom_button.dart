import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/shared/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double elevation;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.backgroundColor = primaryColor,
    this.textColor = Colors.white,
    this.borderRadius = 30.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
    this.elevation = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57,
      child: ElevatedButton(
        onPressed: onPressed,
       
        style: ElevatedButton.styleFrom(
           
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
          elevation: elevation,
          
        ),
        child: Text(buttonText,
            style: GoogleFonts.merriweather(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            )),
      ),
    );
  }
}
