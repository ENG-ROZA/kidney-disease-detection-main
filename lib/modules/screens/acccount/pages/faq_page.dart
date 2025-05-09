import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/widgets/faq_widegt.dart';

class FaqPage extends StatelessWidget {
  FaqPage({super.key});
  static const String routeName = "FaqPage";
  final List<String> faqAnswers = [
    "The app provides highly accurate AI-based analysis but is not a substitute for a doctor. Always consult a professional for confirmation.",
    "The app provides highly accurate AI-based analysis but is not a substitute for a doctor. Always consult a professional for confirmation.",
    "No, the app currently supports only one language.",
    "You can upload your test results and scans by selecting the upload option in the app, choosing your file, and confirming the upload.",
    "No, the app is not a replacement for a doctor. It provides an initial analysis, but you should consult a medical professional for an accurate diagnosis and treatment.",
    "If the results are unclear or confusing, it's best to consult a doctor or medical professional for a detailed explanation and proper guidance."
  ];
  final List<String> faqQuestions = [
    "Can the app accurately diagnose my condition?",
    "How accurate is the app’s diagnosis?",
    "Does the app support multiple languages?",
    "How can I upload my test results and scans?",
    "Is the app a replacement for a doctor?",
    "What should I do if the results are unclear or confusing?"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
           surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
        title: Text(
          "FAQ Content",
          style: GoogleFonts.merriweather(
            color: const Color(0xFF000000),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "All FAQs",
              style: GoogleFonts.merriweather(
                color: const Color(0xFF000000),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                scrollDirection: Axis.vertical,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return faqWideget(
                    answerString: Text(
                      faqAnswers[index],
                      style: GoogleFonts.crimsonText(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF000000).withOpacity(0.5)),
                    ),
                    questionString: Text(
                      faqQuestions[index],
                      style: GoogleFonts.crimsonText(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
