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

  VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final _formKey = GlobalKey<FormState>();

  Future<Response?>? _verifyEmailFuture; // Track the login process

  void _verifyEmail(
      {required BuildContext context, required String verifyEmailController}) {
    if (!_formKey.currentState!.validate()) return;

    // Set the Future to track the login process
    setState(() {
      _verifyEmailFuture =
          ApiManager.verifyEmail(verifyEmailController, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
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
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 18,
              )),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            var provider = Provider.of<AppProvider>(context);
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Image.asset(
                    "assets/images/authlogo.png",
                    height: 120,
                    width: 200,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.04),
                  Text(
                    "Forgot password?",
                    style: GoogleFonts.merriweather(
                        fontSize: 30,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Don’t worry! It happens. Please enter the email associated with your account.",
                    style: GoogleFonts.crimsonText(
                        fontSize: 16,
                        color: secondryColor,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
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
                          ]),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.3),
                  FutureBuilder<Response?>(
                      future: _verifyEmailFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 24.0),
                            child: authButtonLoadingWidget(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("error"),
                          );
                        } else if (snapshot.hasData) {
                          final response = snapshot.data!;
                          if (response.statusCode == 200) {
                            Navigator.pushNamed(context, OtpScreen.routeName,
                                arguments: provider.verifyEmailController.text);
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.all(14),
                          child: CustomButton(
                            buttonText: "Send Email",
                            onPressed: () => _verifyEmail(
                                context: context,
                                verifyEmailController:
                                    provider.verifyEmailController.text),
                          ),
                        );
                      }),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Remember password ?",
                        style: GoogleFonts.crimsonText(
                            color: secondryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.crimsonText(
                                color: const Color(0xFF000000),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ))
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}
