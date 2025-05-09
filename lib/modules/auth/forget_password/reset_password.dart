import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/layout/provider/app_provider.dart';
import 'package:graduation_project/modules/auth/forget_password/otp_screen.dart';
import 'package:graduation_project/modules/auth/login/login.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/widgets/components.dart';
import 'package:graduation_project/widgets/custom_button.dart';
import 'package:graduation_project/widgets/message/messages_methods.dart';
import 'package:graduation_project/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../../../shared/network/remote/api_manager.dart';

class ResetPassword extends StatefulWidget {
  static const String routeName = "ResetPassword";

  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  Future<Response?>? _resetPasswordFuture;

  late TextEditingController createPasswordController = TextEditingController();

  late TextEditingController confirmPasswordController =
      TextEditingController();
  String? email;

  @override
  void initState() {
    super.initState();
    createPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs != null) {
      email = routeArgs as String;
    }
  }

  void _ResetPassword({required BuildContext context}) {
    if (!_formKey.currentState!.validate()) return;
    if (email == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email not found.')),
      );
      return;
    }

    setState(() {
      _resetPasswordFuture = ApiManager.resetAndUpdateOldPassword(
        email!.trim(),
        createPasswordController.text.trim(),
        confirmPasswordController.text.trim(),
        context,
      );
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
              Navigator.pushNamed(context, OtpScreen.routeName);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            )),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Center(
            child: Column(children: [
              SizedBox(height: constraints.maxHeight * 0.02),
              Image.asset(
                "assets/images/authlogo.png",
                height: 120,
                width: 200,
              ),
              SizedBox(height: constraints.maxHeight * 0.04),
              Text(
                "Reset Password",
                style: GoogleFonts.merriweather(
                    fontSize: 30,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Please type something you’ll remember",
                style: GoogleFonts.crimsonText(
                    fontSize: 16,
                    color: secondryColor,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: constraints.maxHeight * 0.1),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headTitlesOfTextField("Create Password"),
                        CustomTextFormField(
                          validator: (text) {
                            {
                              if (text == null || text.trim().isEmpty) {
                                return 'Password must not be empty. Please try again.';
                              }
                              if (text.length < 8) {
                                return 'Password should be at least 8 characters.';
                              }
                              final passwordRegExp = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (!passwordRegExp.hasMatch(text)) {
                                return "Password must contain at least 8 characters - 1 uppercase letter \n1 lowercase letter - 1 number - 1 symbol .";
                              }

                              return null;
                            }
                          },
                          hintText: "Enter your password",
                          controller: createPasswordController,
                          suffixIcon: IconButton(
                            onPressed: () =>
                                provider.toggleObscureText(provider.isHidden),
                            icon: provider.isHidden
                                ? const Icon(
                                    Icons.visibility_outlined,
                                    size: 20,
                                    color: secondryColor,
                                  )
                                : const Icon(
                                    Icons.visibility_off_outlined,
                                    size: 20,
                                    color: secondryColor,
                                  ),
                          ),
                          obscureText: provider.isHidden,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        headTitlesOfTextField("Confirm Password"),
                        CustomTextFormField(
                          validator: (text) {
                            {
                              if (text == null || text.trim().isEmpty) {
                                return 'Invalid password. Follow the rules.';
                              }
                              if (text != createPasswordController.text) {
                                return 'Passwords do not match. Please Try again.';
                              }

                              return null;
                            }
                          },
                          hintText: "Enter your password",
                          controller: confirmPasswordController,
                          suffixIcon: IconButton(
                            onPressed: () =>
                                provider.toggleObscureText(provider.isHidden),
                            icon: provider.isHidden
                                ? const Icon(
                                    Icons.visibility_outlined,
                                    size: 20,
                                    color: secondryColor,
                                  )
                                : const Icon(
                                    Icons.visibility_off_outlined,
                                    size: 20,
                                    color: secondryColor,
                                  ),
                          ),
                          obscureText: provider.isHidden,
                        ),
                      ]),
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.1),
              FutureBuilder<Response?>(
                future: _resetPasswordFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      child: authButtonLoadingWidget(),
                    );
                  } else if (snapshot.hasError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Reset Password Failed"),
                          content: Text("Error: ${snapshot.error}"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    });
                  } else if (snapshot.hasData) {
                    final response = snapshot.data!;
                    final data = response.data;

                    if (response.statusCode == 200 && data["success"] == true) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showSuccessMessage(
                            context, "Your password has been reset");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      });
                    } else {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showErrorMessage(
                            context, data["message"] ?? "Something Went Wrong");
                      });
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: CustomButton(
                      buttonText: "Reset Password",
                      onPressed: () => _ResetPassword(context: context),
                    ),
                  );
                },
              ),
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
            ]),
          ),
        );
      }),
    );
  }
}
