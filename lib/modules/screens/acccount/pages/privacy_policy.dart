import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  static const String routeName = 'PrivacyPolicy';

  final String cancellationPolicy = '''
We understand that sometimes plans change. If you need to cancel your appointment or booking, please notify us at least 24 hours in advance to avoid any cancellation fees. Cancellations made within 24 hours of the scheduled time may incur a fee. We appreciate your understanding and cooperation in adhering to this policy to ensure smooth service for all our clients.
  ''';

  final String termsAndConditions = '''
By using our app, you agree to comply with and be bound by the following terms and conditions. Please read them carefully before accessing or using our services.

General Use:
Our services are for personal use only. Do not use them for illegal activities.

Account Responsibility:
You are responsible for your account and must notify us of any unauthorized use.

Cancellation & Refunds:
Refer to our cancellation policy for details on cancellations and fees.

Data Privacy:
We protect your personal information as outlined in our Privacy Policy.

Limitations of Liability:
We are not liable for any errors or damages arising from the use of the app.

Changes to Terms:
We may update these terms at any time. Continued use means you accept the updated terms.
  ''';

  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.merriweather(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenHeight * 0.025,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Cancellation Policy", screenHeight),
            _buildSectionText(cancellationPolicy, screenHeight),
            SizedBox(height: screenHeight * 0.02),
            _buildSectionTitle("Terms & Conditions", screenHeight),
            _buildSectionText(termsAndConditions, screenHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, double screenHeight) {
    return Text(
      title,
      style: GoogleFonts.crimsonText(
        fontSize: screenHeight * 0.022,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSectionText(String text, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.01),
      child: Text(
        text,
        style: GoogleFonts.crimsonText(
          fontSize: screenHeight * 0.018,
          fontWeight: FontWeight.normal,
          color: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }
}