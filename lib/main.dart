// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:graduation_project/layout/home_layout.dart';
import 'package:graduation_project/layout/provider/app_provider.dart';
import 'package:graduation_project/modules/auth/forget_password/otp_screen.dart';
import 'package:graduation_project/modules/auth/forget_password/reset_password.dart';
import 'package:graduation_project/modules/auth/forget_password/verify_email.dart';
import 'package:graduation_project/modules/auth/login/login.dart';
import 'package:graduation_project/modules/auth/singup/singup.dart';
import 'package:graduation_project/modules/onboarding/onboarding.dart';
import 'package:graduation_project/modules/screens/acccount/pages/change_password.dart';
import 'package:graduation_project/modules/screens/articles/articles_screen.dart';
import 'package:graduation_project/modules/screens/doctors/doctors_details.dart';
import 'package:graduation_project/modules/screens/doctors/doctors_screen.dart';
import 'package:graduation_project/modules/screens/acccount/pages/faq_page.dart';
import 'package:graduation_project/modules/screens/acccount/pages/help_center.dart';
import 'package:graduation_project/modules/screens/acccount/pages/privacy_policy.dart';
import 'package:graduation_project/modules/screens/acccount/pages/profile_page.dart';
import 'package:graduation_project/modules/screens/doctors/review/edit_review.dart';
import 'package:graduation_project/modules/screens/doctors/review/reviews_screen.dart';
import 'package:graduation_project/modules/screens/egfr/egfr.dart';
import 'package:graduation_project/modules/screens/home/home_screen.dart';
import 'package:graduation_project/modules/screens/profile/profile.dart';
import 'package:graduation_project/modules/screens/scan/scan_details.dart';
import 'package:graduation_project/modules/screens/scan/scan_screen.dart';
import 'package:graduation_project/modules/splash/splash_screen.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:provider/provider.dart';

import 'modules/screens/articles/articles_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachedData.cacheInitialization();
  runApp(ChangeNotifierProvider(
      create: (_) => AppProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          //! These values is a defualt if you don't add a properities for the custom button .
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: primaryColor,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: primaryColor,
              minimumSize: const Size(double.infinity, 48),
              shape: const StadiumBorder(),
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0.0,
          )),
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        HomeLayout.routeName: (_) => HomeLayout(),
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        Profile.routeName: (_) => Profile(),
        SplashScreen.routeName: (_) => SplashScreen(),
     //   ProfilePage.routeName: (_) => ProfilePage(),
        LoginScreen.routeName: (_) => LoginScreen(),
        SignupScreen.routeName: (_) => SignupScreen(),
        OtpScreen.routeName: (_) => OtpScreen(),
        VerifyEmail.routeName: (_) => VerifyEmail(),
        ResetPassword.routeName: (_) => ResetPassword(),
        FaqPage.routeName: (_) => FaqPage(),
        HelpCenter.routeName: (_) => HelpCenter(),
        PrivacyPolicy.routeName: (_) => PrivacyPolicy(),
        Egfr.routeName: (_) => Egfr(),
        DoctorsScreen.routeName: (_) => DoctorsScreen(),
        DoctorsDetails.routeName: (_) => DoctorsDetails(),
        ArticlesScreen.routeName: (_) => ArticlesScreen(),
        ArticlesDetails.routeName: (_) => ArticlesDetails(),
        ScanScreen.routeName: (_) => ScanScreen(),
        UserReviewsScreen.routeName: (_) => UserReviewsScreen(),
        EditReview.routeName: (_) => EditReview(),
            ScanDetails.routeName: (_) => ScanDetails(),
        ChangePassword.routeName: (_) => ChangePassword(),
      },
    );
  }
}
