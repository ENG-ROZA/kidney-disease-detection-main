import 'package:flutter/material.dart';

Widget faqWideget(
    {required Widget answerString, required Widget questionString}) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    width: double.infinity,
    height: 170,
    decoration: BoxDecoration(
      color: const Color(0xFFF3F4F6),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          questionString,
          const SizedBox(
            height: 12,
          ),
          answerString,
        ],
      ),
    ),
  );
}
