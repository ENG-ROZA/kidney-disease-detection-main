import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:graduation_project/core/helper/spaces.dart';
import 'package:graduation_project/core/theming/styles.dart';

class NoNetworkScreen extends StatelessWidget {
  static const String routeName = "/NoNetworkScreen";
  const NoNetworkScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/bro.png"),
            verticalSpace(20),
            Text(
              textAlign: TextAlign.center,
              "You are offline! Please\n check your internet\n connection and try \nagain.",
              style: TextStyles.font20BlackBoldMerriweather,
            ),
            verticalSpace(30),
            Container(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2f79e8),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  shadowColor: Colors.blue.withOpacity(0.5),
                ),
                child: Text(
                  "Ok",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Merriweather",
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
