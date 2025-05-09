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

  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  Future<Response?>? _resetPasswordFuture;
  late TextEditingController createPasswordController;
  late TextEditingController confirmPasswordController;
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

  void _resetPassword({required BuildContext context}) {
    if (!_formKey.currentState!.validate()) return;
    if (email == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email not found.')),
      );
      return;
    }

    setState(() {
      _resetPasswordFuture = ApiManager.resetAndUpdateOldPassword(
        email!,
        createPasswordController.text.trim(),
        confirmPasswordController.text.trim(),
        context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

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
          icon: const Icon(Icons.arrow_back_ios, size: 18),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;
          final maxWidth = constraints.maxWidth;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.04),
            child: Center(
              child: Column(
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
                    "Reset Password",
                    style: GoogleFonts.merriweather(
                      fontSize: screenHeight * 0.035,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: maxHeight * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.05),
                    child: Text(
                      "Please type something you’ll remember",
                      style: GoogleFonts.crimsonText(
                        fontSize: screenHeight * 0.02,
                        color: secondryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: maxHeight * 0.06),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: maxWidth * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headTitlesOfTextField("Create Password"),
                          CustomTextFormField(
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Password must not be empty. Please try again.';
                              }
                              if (text.length < 8) {
                                return 'Password should be at least 8 characters.';
                              }
                              final passwordRegExp = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (!passwordRegExp.hasMatch(text)) {
                                return "Password must contain at least 8 characters - 1 uppercase letter, 1 lowercase letter, 1 number, 1 symbol.";
                              }
                              return null;
                            },
                            hintText: "Enter your password",
                            controller: createPasswordController,
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  provider.toggleObscureText(provider.isHidden),
                              icon: provider.isHidden
                                  ? const Icon(Icons.visibility_outlined,
                                      color: secondryColor)
                                  : const Icon(Icons.visibility_off_outlined,
                                      color: secondryColor),
                            ),
                            obscureText: provider.isHidden,
                          ),
                          SizedBox(height: maxHeight * 0.03),
                          headTitlesOfTextField("Confirm Password"),
                          CustomTextFormField(
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Invalid password. Follow the rules.';
                              }
                              if (text != createPasswordController.text) {
                                return 'Passwords do not match. Please try again.';
                              }
                              return null;
                            },
                            hintText: "Enter your password",
                            controller: confirmPasswordController,
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  provider.toggleObscureText(provider.isHidden),
                              icon: provider.isHidden
                                  ? const Icon(Icons.visibility_outlined,
                                      color: secondryColor)
                                  : const Icon(Icons.visibility_off_outlined,
                                      color: secondryColor),
                            ),
                            obscureText: provider.isHidden,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: maxHeight * 0.08),
                  FutureBuilder<Response?>(
                    future: _resetPasswordFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return authButtonLoadingWidget();
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
                        return const SizedBox.shrink();
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
                            showErrorMessage(context,
                                data["message"] ?? "Something Went Wrong");
                          });
                        }
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.02,
                        ),
                        child: CustomButton(
                          buttonText: "Reset Password",
                          onPressed: () => _resetPassword(context: context),
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
                          fontSize: screenHeight * 0.018,
                          color: secondryColor,
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
                            fontSize: screenHeight * 0.018,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    createPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}