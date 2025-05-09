import 'package:flutter/material.dart';
import 'package:graduation_project/core/helper/spaces.dart';

class OpacityWelcomScreen extends StatelessWidget {
  final VoidCallback onClose;

  const OpacityWelcomScreen({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Icon(Icons.arrow_back_ios_sharp,
              //         size: 18, color: Colors.white),
              //     Stack(
              //       alignment: Alignment.topRight,
              //       children: [
              //         const Icon(Icons.notifications, color: Colors.white),
              //         CircleAvatar(
              //           radius: 5,
              //           backgroundColor: Colors.black.withOpacity(0.5),
              //           foregroundColor: Colors.black.withOpacity(0.5),
              //           child: const CircleAvatar(
              //             radius: 3,
              //             backgroundColor: Colors.red,
              //             foregroundColor: Colors.red,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              verticalSpace(50),
              const Text(
                "Community",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Merriweather",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  height: 2.5,
                  decoration: TextDecoration.none,
                ),
              ),
              verticalSpace(10),
              Image.asset("assets/images/annotation.png"),
              verticalSpace(50),
              const Text(
                "Your Health Support Network \nThe Community section in the app connects you with other users facing similar health concerns. Here, you can share experiences, ask questions, and offer support to one another. Whether you’re looking for advice, sharing progress, or just need someone to talk to, the Community is a safe and welcoming space to interact and learn from others. Together, we are\nstronger.",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Merriweather",
                  fontSize: 10,
                  height: 2.5,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(80),
              ElevatedButton(
                onPressed: onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2f79e8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  shadowColor: Colors.blue.withOpacity(0.5),
                ),
                child: const Text(
                  "Join Community",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Merriweather",
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
