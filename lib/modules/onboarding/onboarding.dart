import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/modules/auth/login/login.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardModel {
  final String image;
  final String title;
  final String body;

  OnBoardModel({required this.image, required this.title, required this.body});
}

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "OnBoarding";

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnBoardModel> onboard = [
    OnBoardModel(
      image: "assets/images/board1.png",
      title: "Hi, I'm Dr. Reni!",
      body:
          "I'm here to help you with AI-Powered CT scan analysis to analyze your kidney. Our advanced model detects potential issues early, giving you actionable insights for proactive care.",
    ),
    OnBoardModel(
      image: "assets/images/board2.png",
      title: "Hey, I'm Wisely!",
      body:
          "Here with you to stay informed with trusted, easy-to-read articles on kidney care, diet tips, and lifestyle adjustments. Updated weekly by medical professionals.",
    ),
    OnBoardModel(
      image: "assets/images/board3.png",
      title: "Hi! my friends",
      body:
          "Supportive kidney health community. Join a thriving community of individuals managing kidney health. Share experiences, ask questions, and find encouragement.",
    ),
    OnBoardModel(
      image: "assets/images/board4.png",
      title: "Hi, I’m Carely!",
      body:
          "I’ll help you connect with top kidney specialists. Access verified, top-rated doctors specializing in kidney care. You can also explore patients' opinions and rate your experience.",
    ),
    OnBoardModel(
      image: "assets/images/onboard5.png",
      title: "Hi, I’m Carely!",
      body:
          "I’ll help you calculate eGFR for kidney health. Track your kidney function effortlessly. Input your lab results to calculate your eGFR, a key indicator of kidney health, and monitor trends over time.",
    ),
  ];

  var boardController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
            child: Text(
              "Skip",
              style: GoogleFonts.crimsonText(
                color: primaryColor,
                fontSize: screenHeight * 0.02,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;
          final maxWidth = constraints.maxWidth;

          return Padding(
            padding: EdgeInsets.all(maxWidth * 0.03),
            child: Column(
              children: [
                SizedBox(height: maxHeight * 0.02),
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        isLast = index == onboard.length - 1;
                      });
                    },
                    controller: boardController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: onboard.length,
                    itemBuilder: (context, index) {
                      return buildOnBoardingWidget(
                          onboard[index], isLast, screenHeight, screenWidth);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildOnBoardingWidget(
    OnBoardModel model,
    bool isLast,
    double screenHeight,
    double screenWidth,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SmoothPageIndicator(
            controller: boardController,
            count: onboard.length,
            effect: ExpandingDotsEffect(
              dotColor: const Color(0xFFF6F6F6),
              activeDotColor: primaryColor,
              expansionFactor: 2.5,
              dotHeight: screenHeight * 0.015,
              dotWidth: screenWidth * 0.03,
              spacing: screenWidth * 0.01,
            ),
          ),
          SizedBox(height: screenHeight * 0.04),
          Image.asset(
            model.image,
            fit: BoxFit.contain,
            height: screenHeight * 0.3,
            width: screenWidth * 0.9,
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              fontWeight: FontWeight.w700,
              fontSize: screenHeight * 0.025,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            model.body,
            textAlign: TextAlign.center,
            style: GoogleFonts.crimsonText(
              fontSize: screenHeight * 0.022,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: screenHeight * 0.07,
            child: FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () {
                if (isLast) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                } else {
                  boardController.nextPage(
                    duration: const Duration(milliseconds: 750),
                    curve: Curves.linear,
                  );
                }
              },
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              elevation: 0,
              child: Text(
                "Next",
                style: GoogleFonts.merriweather(
                  color: const Color(0xFFFFFFFF),
                  fontSize: screenHeight * 0.022,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }
}