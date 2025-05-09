import 'package:flutter/material.dart';
import 'package:graduation_project/modules/onboarding/onboarding.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "SplashScreen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    //! Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    //! Define a scale animation from 0.5x to 1x size
    _animation = Tween<double>(begin: 0.5, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    //! Start the animation
    _controller.forward();

    //! Navigate after animation completes
    Future.delayed(const Duration(milliseconds: 3350), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Center(
            child: ScaleTransition(
              scale: _animation,
              child: Image.asset(
                "assets/images/splash_logo.png",
                alignment: Alignment.center,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: 0.5,
            left: 0,
            right: 0,
            child: Center(
              child: Lottie.asset(
                "assets/animations/Animation - 1744724047858.json",
                repeat: true,
                width: 200,
                height: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
