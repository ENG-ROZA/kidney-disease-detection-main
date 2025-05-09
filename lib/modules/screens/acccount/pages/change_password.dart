import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/layout/provider/app_provider.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/widgets/components.dart';
import 'package:graduation_project/widgets/custom_button.dart';
import 'package:graduation_project/widgets/text_field.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  static const String routeName = "ChangePassword";
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final bool isHidden = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    String token = CachedData.getFromCache("token");
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "Update Password",
            style: GoogleFonts.merriweather(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headTitlesOfTextField("Old Password"),
                CustomTextFormField(
                  keyboardType: TextInputType.text,
                  hintText: "Enter old password",
                  controller: _oldPasswordController,
                  obscureText: provider.isHidden,
                  suffixIcon: IconButton(
                    onPressed: () =>
                        provider.toggleObscureText(provider.isHidden),
                    icon: provider.isHidden
                        ? const Icon(Icons.visibility_outlined,
                            color: secondryColor, size: 20)
                        : const Icon(Icons.visibility_off_outlined,
                            color: secondryColor, size: 20),
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Password must not be empty. Please try again.';
                    }
                    if (text.length < 8) {
                      return 'Password should be at least 8 characters.';
                    }
                    final passwordRegExp = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\\$&*~]).{8,}\$');
                    if (!passwordRegExp.hasMatch(text)) {
                      return "Password must contain at least 8 characters - 1 uppercase letter, 1 lowercase\n1 number, and 1 symbol.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                headTitlesOfTextField("New Password"),
                CustomTextFormField(
                  keyboardType: TextInputType.text,
                  hintText: "Enter new password",
                  controller: _newPasswordController,
                  obscureText: provider.isHidden,
                  suffixIcon: IconButton(
                    onPressed: () =>
                        provider.toggleObscureText(provider.isHidden),
                    icon: provider.isHidden
                        ? const Icon(Icons.visibility_outlined,
                            color: secondryColor, size: 20)
                        : const Icon(Icons.visibility_off_outlined,
                            color: secondryColor, size: 20),
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Password must not be empty. Please try again.';
                    }
                    if (text.length < 8) {
                      return 'Password should be at least 8 characters.';
                    }
                    final passwordRegExp = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\\$&*~]).{8,}\$');
                    if (!passwordRegExp.hasMatch(text)) {
                      return "Password must contain at least 8 characters - 1 uppercase letter, 1 lowercase\n1 number, and 1 symbol.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                headTitlesOfTextField("Confirm Password"),
                CustomTextFormField(
                  keyboardType: TextInputType.text,
                  hintText: "Enter confirm password",
                  controller: _confirmNewPasswordController,
                  obscureText: provider.isHidden,
                  suffixIcon: IconButton(
                    onPressed: () =>
                        provider.toggleObscureText(provider.isHidden),
                    icon: provider.isHidden
                        ? const Icon(Icons.visibility_outlined,
                            color: secondryColor, size: 20)
                        : const Icon(Icons.visibility_off_outlined,
                            color: secondryColor, size: 20),
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Invalid password. Follow the rules.';
                    }
                    if (text != _newPasswordController.text) {
                      return 'Passwords do not match. Please try again.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                CustomButton(
                  buttonText: "Update",
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                  },
                )
              ]),
        ));
  }
}
