import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NotificationsIconAppBare extends StatelessWidget {
  const NotificationsIconAppBare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/NoNetworkScreen');
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Icon(
              Icons.notifications,
              color: Color(0xff006bff),
            ),
            CircleAvatar(
              radius: 5,
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              child: CircleAvatar(
                radius: 3,
                backgroundColor: Colors.red,
                foregroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
