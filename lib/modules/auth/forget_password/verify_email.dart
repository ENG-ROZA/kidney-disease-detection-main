import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/layout/provider/app_provider.dart';
import 'package:graduation_project/modules/auth/forget_password/otp_screen.dart';
import 'package:graduation_project/modules/auth/login/login.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/widgets/components.dart';
import 'package:graduation_project/widgets/custom_button.dart';
import 'package:graduation_project/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../../../shared/network/remote/api_manager.dart';

class VerifyEmail extends StatefulWidget {
  static const String routeName = "VerifyEmail";

  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final _formKey = GlobalKey<FormState>();

  Future<Response?>? _verifyEmailFuture;

  void _verifyEmail({
    required BuildContext context,
    required String verifyEmailController,
  }) {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _verifyEmailFuture =
          ApiManager.verifyEmail(verifyEmailController, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, LoginScreen.routeName);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 18),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;
          final maxWidth = constraints.maxWidth;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: maxWidth * 0.04, 
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: maxHeight * 0.02),
                Container(
                  height: maxHeight * 0.15,
                  width: maxWidth * 0.5,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/authlogo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: maxHeight * 0.03),
                Text(
                  "Forgot password?",
                  style: GoogleFonts.merriweather(
                    fontSize: screenHeight * 0.03,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: maxHeight * 0.01),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.05),
                  child: Text(
                    "Don’t worry! It happens. Please enter the email associated with your account.",
                    style: GoogleFonts.crimsonText(
                      fontSize: screenHeight * 0.02,
                      color: secondryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: maxHeight * 0.04),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headTitlesOfTextField("Email"),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Enter your email",
                        controller: provider.verifyEmailController,
                        suffixIcon: const Icon(
                          Icons.email,
                          color: secondryColor,
                          size: 20,
                        ),
                        obscureText: false,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Email must not be empty. Please try again.';
                          }
                          final emailRegExp = RegExp(
                              r"^(?=\S)([a-zA-Z0-9._%+-]+)@([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$");

                          if (!emailRegExp.hasMatch(text)) {
                            return "Please enter a valid email address (example@mail.com).";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: maxHeight * 0.08),
                FutureBuilder<Response?>(
                  future: _verifyEmailFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                          horizontal: screenWidth * 0.05,
                        ),
                        child: authButtonLoadingWidget(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (snapshot.hasData) {
                      final response = snapshot.data!;
                      if (response.statusCode == 200) {
                        Navigator.pushNamed(
                          context,
                          OtpScreen.routeName,
                          arguments: provider.verifyEmailController.text,
                        );
                      }
                    }

                    return Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: CustomButton(
                        buttonText: "Send Email",
                        onPressed: () => _verifyEmail(
                          context: context,
                          verifyEmailController:
                              provider.verifyEmailController.text,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Remember password ?",
                      style: GoogleFonts.crimsonText(
                        color: secondryColor,
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.crimsonText(
                          color: const Color(0xFF000000),
                          fontSize: screenHeight * 0.018,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}