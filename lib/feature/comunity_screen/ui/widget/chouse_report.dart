import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/theming/font_weight_helper.dart';

class ChouseTheReport extends StatelessWidget {
  const ChouseTheReport({
    super.key,
    required this.selectedValue,
    required this.mainText,
    required this.onChanged,
    this.subText,
  });

  final String selectedValue;
  final String mainText;
  final String? subText;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio<String>(
              value: mainText,
              groupValue: selectedValue,
              onChanged: onChanged,
              activeColor: Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                mainText,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeightHelper.bold,
                  color: Colors.black,
                  fontFamily: "Merriweather",
                ),
              ),
            ),
          ],
        ),
        if (subText != null)
          Text(
            subText!,
            style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeightHelper.medium,
              color: Colors.grey,
              fontFamily: "Merriweather",
            ),
          ),
      ],
    );
  }
}
