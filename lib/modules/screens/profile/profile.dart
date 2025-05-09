import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/modules/auth/login/login.dart';
import 'package:graduation_project/modules/screens/acccount/pages/change_password.dart';
import 'package:graduation_project/modules/screens/acccount/pages/faq_page.dart';
import 'package:graduation_project/modules/screens/acccount/pages/help_center.dart';
import 'package:graduation_project/modules/screens/acccount/pages/privacy_policy.dart';
import 'package:graduation_project/modules/screens/acccount/pages/profile_page.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';
import 'package:graduation_project/shared/network/remote/api_manager.dart';
import 'package:graduation_project/layout/provider/app_provider.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/shared/utils/dialogs.dart';
import 'package:graduation_project/widgets/message/messages_methods.dart';
import 'package:graduation_project/widgets/shimmer_effects.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  static const String routeName = "Profile";

  final headerTextStyle = GoogleFonts.merriweather(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  final itemTextStyle = GoogleFonts.crimsonText(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black.withOpacity(0.7));
  void logout(BuildContext context) async {
    //! print("Pre-logout token: ${CachedData.getFromCache("token")}"); //? For debugging
    String token = CachedData.getFromCache("token");
    try {
      print("Sending token: $token");
      showLoadingDialog(context);
      Response? response =
          await ApiManager.logOut(context: context, token: token);
      //! print("API response: ${response?.data}"); //? For debugging
      if (response?.data["success"] == true) {
        await CachedData.deleteFromCache("token");
        //! print("Post-deletion token: ${CachedData.getFromCache("token")}"); //? For debugging
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        showSuccessMessage(context, "You have been logged out successfully");

        Provider.of<AppProvider>(context, listen: false).resetTabIndex();
      }
    } catch (e) {
      showError(context, e.toString());
    }
  }

  void clearAccount(BuildContext context) async {
    String token = CachedData.getFromCache("token");
    showLoadingDialog(context);
    try {
      Response? response =
          await ApiManager.deleteAccount(context: context, token: token);

      if (response?.data["success"] == true) {
        await CachedData.deleteFromCache("token");

        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          showCloseIcon: true,
          backgroundColor: Colors.lightBlue,
          duration: const Duration(seconds: 5),
          content: Text(
            "Your account has been deleted successfully",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ));
        Provider.of<AppProvider>(context, listen: false).resetTabIndex();
      }
    } catch (e) {
      showError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    String token = CachedData.getFromCache("token");
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                child: Center(child: buildProfileItem(token))),
            const SizedBox(height: 10),
            Text(
              "Privacy",
              style: headerTextStyle,
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicy(),
                    ));
              },
              child: buildDrawerItem("assets/images/privacy.png",
                  "Privacy Policy", Icons.arrow_forward_ios),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePassword(),
                    ));
              },
              child: buildDrawerItem("assets/images/changepassword.png",
                  "Change Password", Icons.arrow_forward_ios),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1.5,
              endIndent: 15,
              color: Color(0xFFD1D5DB),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Help and Support",
              style: headerTextStyle,
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FaqPage(),
                    ));
              },
              child: buildDrawerItem(
                "assets/images/faqq.png",
                "FAQs",
                Icons.arrow_forward_ios,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpCenter(),
                    ));
              },
              child: buildDrawerItem("assets/images/helpcenter.png",
                  "Help Center", Icons.arrow_forward_ios),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 1.5,
              endIndent: 15,
              color: Color(0xFFD1D5DB),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Dangerous Zone",
              style: headerTextStyle,
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                warningDialog(
                  context,
                  "Are you sure want to delete your account?",
                  "Delete",
                  () {
                    clearAccount(context);
                  },
                );
              },
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  "assets/images/delete.png",
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  "Delete Account",
                  style: GoogleFonts.crimsonText(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFe90005)),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFe90005),
                  size: 15,
                ),
              ]),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              thickness: 1.5,
              endIndent: 15,
              color: Color(0xFFD1D5DB),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Sign Out",
              style: headerTextStyle,
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                warningDialog(
                  context,
                  "Are you sure want to logout?",
                  "Logout",
                  () {
                    logout(context);
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => LoginScreen()),
                    //     (route) => false);
                  },
                );
              },
              child: buildDrawerItem("assets/images/signout.png", "Logout",
                  Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem(String leftIcon, String title, IconData rightIcon) =>
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(
          width: 10,
        ),
        Image.asset(
          leftIcon,
          height: 33,
          width: 33,
        ),
        const SizedBox(
          width: 18,
        ),
        Text(
          title,
          style: itemTextStyle,
        ),
        const Spacer(),
        Icon(
          rightIcon,
          color: Colors.black.withOpacity(0.7),
          size: 15,
        ),
      ]);
}

Widget buildProfileItem(String token) {
  return FutureBuilder(
      future: ApiManager.getUserData(token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return profileShimmerEffect();
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        final userData = snapshot.data?.results;

        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Image.network(
                userData?.user?.profileImage?.url.toString() ?? "",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              userData?.user?.userName.toString() ?? "",
              style: GoogleFonts.merriweather(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ],
        );
      });
}
