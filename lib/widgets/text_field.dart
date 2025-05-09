import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/shared/utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? suffix;
  final int? maxLength;

  const CustomTextFormField({
    super.key,
    this.labelText,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.validator,
    this.obscureText,
    this.keyboardType,
    this.suffix,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        focusColor: primaryColor,
        suffix: suffix,
        suffixIcon: suffixIcon,
        errorStyle: GoogleFonts.crimsonText(
          fontSize: 10,
          fontWeight: FontWeight.normal,
        ),
        hintStyle: GoogleFonts.crimsonText(
            fontSize: 16, fontWeight: FontWeight.w400, color: secondryColor),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF9EA1AE)),
            borderRadius: BorderRadius.all(Radius.circular(28.0))),
        contentPadding: const EdgeInsets.symmetric(horizontal: 23),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF9EA1AE)),
          borderRadius: BorderRadius.circular(28.0),
        ),
      ),
      validator: validator,
      obscureText: obscureText ?? true,
      keyboardType: keyboardType,
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }
}
