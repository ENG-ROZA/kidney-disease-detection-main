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
            " I'm here to help you with AI-Powered CT scan analysis to analyze your kidney. Our advanced model detects potential issues early, giving you actionable insights for proactive care."),
    OnBoardModel(
        image: "assets/images/board2.png",
        title: "Hey, I'm Wisely!",
        body:
            " Here with you to stay informed with trusted, easy-to-read articles on kidney care, diet tips, and lifestyle adjustments. Updated weekly by medical professionals."),
    OnBoardModel(
        image: "assets/images/board3.png",
        title: "Hi! my friends",
        body:
            "Supportive kidney health community join a thriving community of individuals managing kidney health. Share experiences, ask questions, and find encouragement."),
    OnBoardModel(
        image: "assets/images/board4.png",
        title: "Hi, I’m Carely!",
        body:
            " I’ll help you connect with top kidney specialists access verified, top rated doctors specializing in kidney care. You can also explore patients opinions and you can rate your experience."),
    OnBoardModel(
        image: "assets/images/onboard5.png",
        title: "Hi, I’m Carely!",
        body:
            " I’ll help you calculate eGFR for kidney health to track your kidney function effortlessly. Input your lab results to calculate your eGFR, a key indicator of kidney health, and monitor trends over time"),
  ];
  var boardController = PageController();
  bool isLast = false;
  bool isFirst = false;

  @override
  Widget build(BuildContext context) {
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
            child: Text("Skip",
                style: GoogleFonts.crimsonText(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == onboard.length - 1) {
                    setState(() {
                      isLast = true;
                      isFirst = false;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                      isFirst = true;
                    });
                  }
                },
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildOnBoardingWidget(onboard[index], isLast);
                },
                itemCount: onboard.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingWidget(OnBoardModel model, bool isLast) => Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SmoothPageIndicator(
              controller: boardController,
              count: onboard.length,
              effect: const ExpandingDotsEffect(
                dotColor: Color(0xFFF6F6F6),
                activeDotColor: primaryColor,
                expansionFactor: 2.5,
                dotHeight: 10,
                dotWidth: 12,
                spacing: 5,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Image.asset(
              model.image,
              scale: 4,
            ),
            const SizedBox(
              height: 20,
            ),
            Text("  ${model.title} ",
                style: GoogleFonts.merriweather(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.8))),
            Align(
              alignment: Alignment.center,
              child: Text(
                model.body,
                textAlign: TextAlign.center,
                style: GoogleFonts.crimsonText(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () {
                  if (isLast) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  }
                  boardController.nextPage(
                      duration: const Duration(milliseconds: 750),
                      curve: Curves.linear);
                },
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
                elevation: 0,
                child: Text(
                  "Next",
                  style: GoogleFonts.merriweather(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      );
}
