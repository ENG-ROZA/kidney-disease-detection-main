import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/font_weight_helper.dart';

class TextStyles {
  static TextStyle font20BlackBoldMerriweather = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.black,
    fontFamily: "Merriweather",
  );
  static TextStyle font20greyregularMerriweather = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.bold,
    color: Color(0xff666666),
    fontFamily: "Merriweather",
  );
  static TextStyle font18BlackboldMerriweather = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.black,
    fontFamily: "Merriweather",
  );
}
