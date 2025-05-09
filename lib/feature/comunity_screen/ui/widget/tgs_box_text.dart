import 'package:flutter/material.dart';
import 'package:graduation_project/core/theming/font_weight_helper.dart';

class TagsBoxText extends StatelessWidget {
  const TagsBoxText({
    super.key,
    required this.tag,
    required this.tagColor,
  });
  final String tag;
  final Color tagColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          color: tagColor, borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Text(
        "  $tag",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeightHelper.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
