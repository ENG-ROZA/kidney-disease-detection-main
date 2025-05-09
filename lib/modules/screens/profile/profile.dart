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

  final double baseScreenWidth = 414; // Reference width (iPhone 12 Pro Max)

  double getResponsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    return baseSize * (screenWidth / baseScreenWidth);
  }

  final TextStyle headerTextStyle = const TextStyle(); // Will be updated dynamically
  final TextStyle itemTextStyle = const TextStyle(); // Will be updated dynamically

  void logout(BuildContext context) async {
    String token = CachedData.getFromCache("token");
    try {
      showLoadingDialog(context);
      Response? response =
          await ApiManager.logOut(context: context, token: token);
      if (response?.data["success"] == true) {
        await CachedData.deleteFromCache("token");
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
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    final headerTextStyle = GoogleFonts.merriweather(
      fontSize: getResponsiveFontSize(context, 16),
      fontWeight: FontWeight.bold,
    );

    final itemTextStyle = GoogleFonts.crimsonText(
      fontSize: getResponsiveFontSize(context, 16),
      fontWeight: FontWeight.bold,
      color: Colors.black.withOpacity(0.7),
    );

    String token = CachedData.getFromCache("token");

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                
                  },
                  child: Center(child: buildProfileItem(token, screenHeight)),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Privacy",
                  style: headerTextStyle,
                ),
                SizedBox(height: screenHeight * 0.02),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicy(),
                      ),
                    );
                  },
                  child: buildDrawerItem(
                    "assets/images/privacy.png",
                    "Privacy Policy",
                    Icons.arrow_forward_ios,
                    screenHeight,
                    screenWidth,
                    itemTextStyle,
                  ),
                ),
                   SizedBox(height: screenHeight * 0.02),
                // SizedBox(height: screenHeight * 0.02),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ChangePassword(),
                //       ),
                //     );
                //   },
                //   child: buildDrawerItem(
                //     "assets/images/changepassword.png",
                //     "Change Password",
                //     Icons.arrow_forward_ios,
                //     screenHeight,
                //     screenWidth,
                //     itemTextStyle,
                //   ),
                // ),
                SizedBox(height: screenHeight * 0.01),
                const Divider(
                  thickness: 1.5,
                  endIndent: 15,
                  color: Color(0xFFD1D5DB),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Help and Support",
                  style: headerTextStyle,
                ),
                SizedBox(height: screenHeight * 0.02),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FaqPage(),
                      ),
                    );
                  },
                  child: buildDrawerItem(
                    "assets/images/faqq.png",
                    "FAQs",
                    Icons.arrow_forward_ios,
                    screenHeight,
                    screenWidth,
                    itemTextStyle,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HelpCenter(),
                      ),
                    );
                  },
                  child: buildDrawerItem(
                    "assets/images/helpcenter.png",
                    "Help Center",
                    Icons.arrow_forward_ios,
                    screenHeight,
                    screenWidth,
                    itemTextStyle,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Divider(
                  thickness: 1.5,
                  endIndent: 15,
                  color: Color(0xFFD1D5DB),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Dangerous Zone",
                  style: headerTextStyle,
                ),
                SizedBox(height: screenHeight * 0.02),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: screenWidth * 0.02),
                      Image.asset(
                        "assets/images/delete.png",
                        height: screenHeight * 0.03,
                        width: screenHeight * 0.03,
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Text(
                        "Delete Account",
                        style: GoogleFonts.crimsonText(
                          fontSize: getResponsiveFontSize(context, 16),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFe90005),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: const Color(0xFFe90005),
                        size: screenHeight * 0.02,
                      ),
                    ],
                  ),
                ),
             SizedBox(height: screenHeight * 0.02),
                const Divider(
                  thickness: 1.5,
                  endIndent: 15,
                  color: Color(0xFFD1D5DB),
                ),
                 SizedBox(height: screenHeight * 0.02),
                Text(
                  "Sign Out",
                  style: headerTextStyle,
                ),
                SizedBox(height: screenHeight * 0.02),
                GestureDetector(
                  onTap: () {
                    warningDialog(
                      context,
                      "Are you sure want to logout?",
                      "Logout",
                      () {
                        logout(context);
                      },
                    );
                  },
                  child: buildDrawerItem(
                    "assets/images/signout.png",
                    "Logout",
                    Icons.arrow_forward_ios,
                    screenHeight,
                    screenWidth,
                    itemTextStyle,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDrawerItem(
    String leftIcon,
    String title,
    IconData rightIcon,
    double screenHeight,
    double screenWidth,
    TextStyle itemTextStyle,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: screenWidth * 0.02),
          Image.asset(
            leftIcon,
            height: screenHeight * 0.035,
            width: screenHeight * 0.035,
          ),
          SizedBox(width: screenWidth * 0.04),
          Text(
            title,
            style: itemTextStyle,
          ),
          const Spacer(),
          Icon(
            rightIcon,
            color: Colors.black.withOpacity(0.7),
            size: screenHeight * 0.02,
          ),
        ],
      );

  Widget buildProfileItem(String token, double screenHeight) {
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
              radius: screenHeight * 0.07,
              child: ClipOval(
                child: Image.network(
                  userData?.user?.profileImage?.url.toString() ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              userData?.user?.userName.toString() ?? "",
              style: GoogleFonts.merriweather(
                color: Colors.black.withOpacity(0.8),
                fontSize: screenHeight * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}