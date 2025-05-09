import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/feature/comunity_screen/ui/screen/profile_screen.dart';

class ProfileImageDesign extends StatelessWidget {
  const ProfileImageDesign({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(image),
    );
  }
}
