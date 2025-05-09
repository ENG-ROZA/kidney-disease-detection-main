import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/layout/provider/app_provider.dart';
import 'package:graduation_project/modules/auth/login/login.dart';
import 'package:graduation_project/shared/network/remote/api_manager.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/shared/utils/dialogs.dart';
import 'package:graduation_project/widgets/components.dart';
import 'package:graduation_project/widgets/custom_button.dart';
import 'package:graduation_project/widgets/message/messages_methods.dart';
import 'package:graduation_project/widgets/text_field.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = "Signup";

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final bool isHidden = true;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _createPasswordController =
      TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  Future<Response?>? _signUpFuture;
  void _singUp(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String createPassword = _createPasswordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      _signUpFuture = ApiManager.signUp(
          email, createPassword, confirmPassword, name, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Image.asset(
                    "assets/images/authlogo.png",
                    height: 120,
                    width: 200,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.04),
                  Text(
                    "Create Account",
                    style: GoogleFonts.merriweather(
                        fontSize: 30,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Create an account to explore all the\n existing Features",
                    style: GoogleFonts.crimsonText(
                        fontSize: 16,
                        color: secondryColor,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headTitlesOfTextField("Name"),
                          CustomTextFormField(
                            keyboardType: TextInputType.name,
                            suffixIcon: const Icon(
                              Icons.person_pin_rounded,
                              color: secondryColor,
                              size: 20,
                            ),
                            hintText: "Enter your name",
                            obscureText: false,
                            controller: _nameController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Name must not be empty. Please try again.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          headTitlesOfTextField("Email"),
                          CustomTextFormField(
                            hintText: "Enter your email",
                            obscureText: false,
                            controller: _emailController,
                            suffixIcon: const Icon(
                              Icons.email_outlined,
                              color: secondryColor,
                              size: 20,
                            ),
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
                          const SizedBox(
                            height: 30,
                          ),
                          headTitlesOfTextField("Create Password"),
                          CustomTextFormField(
                            keyboardType: TextInputType.text,
                            hintText: "Enter your password",
                            controller: _createPasswordController,
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  provider.toggleObscureText(provider.isHidden),
                              icon: provider.isHidden
                                  ? const Icon(
                                      Icons.visibility_outlined,
                                      color: secondryColor,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.visibility_off_outlined,
                                      color: secondryColor,
                                      size: 20,
                                    ),
                            ),
                            obscureText: provider.isHidden,
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
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          headTitlesOfTextField("Confirm Password"),
                          CustomTextFormField(
                            keyboardType: TextInputType.text,
                            hintText: "Enter your password",
                            controller: _confirmPasswordController,
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  provider.toggleObscureText(provider.isHidden),
                              icon: provider.isHidden
                                  ? const Icon(
                                      Icons.visibility_outlined,
                                      color: secondryColor,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.visibility_off_outlined,
                                      color: secondryColor,
                                      size: 20,
                                    ),
                            ),
                            obscureText: provider.isHidden,
                            validator: (text) {
                              {
                                if (text == null || text.trim().isEmpty) {
                                  return 'Invalid password. Follow the rules.';
                                }
                                if (text != _createPasswordController.text) {
                                  return 'Passwords do not match.Please Try again.';
                                }

                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          FutureBuilder<Response?>(
                            future: _signUpFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return authButtonLoadingWidget();
                              } else if (snapshot.hasError) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  showErrorMessage(
                                      context, snapshot.error.toString());
                                });
                              } else if (snapshot.hasData) {
                                final response = snapshot.data!;
                                final data = response.data;

                                if (response.statusCode == 200 &&
                                    data["success"] == true) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    showSuccessMessage(
                                        context, data["message"]);
                                  });
                                } else {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const LoginScreen(),
                                      ),
                                    );
                                    showSuccessMessage(context,
                                        "your account created verify it");
                                  });
                                }
                              }

                              return CustomButton(
                                buttonText: "Sign Up",
                                onPressed: () => _singUp(context),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  color: Color(0xFF8B8C9F),
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('or continue with',
                                    style: GoogleFonts.crimsonText(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                              ),
                              const Expanded(
                                child: Divider(
                                  color: Color(0xFF8B8C9F),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          MaterialButton(
                            onPressed: () {},
                            height: 70,
                            elevation: 0,
                            color: const Color(0xFFFFFFFF),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Color(0xFFD8DADC),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/google.png",
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Sign in with Google",
                                  style: GoogleFonts.crimsonText(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: GoogleFonts.crimsonText(
                                    color: secondryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.crimsonText(
                                        color: const Color(0xFF000000),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
