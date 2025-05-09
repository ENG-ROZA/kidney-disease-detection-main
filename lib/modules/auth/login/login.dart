import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/layout/home_layout.dart';
import 'package:graduation_project/layout/provider/app_provider.dart';
import 'package:graduation_project/modules/auth/forget_password/verify_email.dart';
import 'package:graduation_project/modules/auth/singup/singup.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/shared/utils/dialogs.dart';
import 'package:graduation_project/widgets/components.dart';
import 'package:graduation_project/widgets/custom_button.dart';
import 'package:graduation_project/widgets/message/messages_methods.dart';
import 'package:graduation_project/widgets/scan_animation.dart';
import 'package:graduation_project/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../../../shared/network/remote/api_manager.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "Login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<Response?>? _loginFuture;

  void _login(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    setState(() {
      _loginFuture = ApiManager.login(email, password, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.06),
                Image.asset(
                  "assets/images/authlogo.png",
                  height: 120,
                  width: 200,
                ),
                SizedBox(height: constraints.maxHeight * 0.04),
                Text(
                  "Sign In Here",
                  style: GoogleFonts.merriweather(
                      fontSize: 30,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Welcome back you've \n been missed",
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
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headTitlesOfTextField("Email"),
                        CustomTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Enter your email",
                          controller: _emailController,
                          suffixIcon: const Icon(
                            Icons.email_outlined,
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
                              provider.showSuffixIconInError(ishasError: true);

                              return "Please enter a valid email address (example@mail.com).";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        headTitlesOfTextField("Password"),
                        CustomTextFormField(
                          keyboardType: TextInputType.text,
                          hintText: "Enter your password",
                          controller: _passwordController,
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
                            if (text == null || text.trim().isEmpty) {
                              return 'Password must not be empty. Please try again.';
                            }
                            if (text.length < 8) {
                              return 'Password should be at least 8 characters.';
                            }
                            final passwordRegExp = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (!passwordRegExp.hasMatch(text)) {
                              return "Password must contain at least 8 characters - 1 uppercase letter, 1 lowercase\n1 number, and 1 symbol.";
                            }

                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, VerifyEmail.routeName);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.crimsonText(
                                  color: primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FutureBuilder<Response?>(
                            future: _loginFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return authButtonLoadingWidget();
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: Text("error"),
                                );
                              } else if (snapshot.hasData) {
                                final response = snapshot.data!;
                                if (response.statusCode == 200) {
                                  final data = response.data;
                                  if (data["success"] == true) {
                                    CachedData.insertToCache(
                                        key: "token",
                                        value: data["results"]["token"]);
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      showSuccessMessage(context,
                                          "You have been logged in successfully");
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeLayout(),
                                        ),
                                        (route) => false,
                                      );
                                    });
                                  } else {
                                    return const Text("Error to Login");
                                  }
                                } else {
                                  return const Center(
                                      child: Text(
                                          "Login failed. Please try again."));
                                }
                              }

                              return CustomButton(
                                buttonText: "Login",
                                onPressed: () => _login(context),
                              );
                            }),
                        const SizedBox(
                          height: 32,
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
                          height: 20,
                        ),
                        MaterialButton(
                          onPressed: () {
                            //! singInWithGoogle();
                            progressDialog(context);
                          },
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
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.crimsonText(
                                  color: secondryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, SignupScreen.routeName);
                                },
                                child: Text(
                                  "SignUp",
                                  style: GoogleFonts.crimsonText(
                                      color: const Color(0xFF000000),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
