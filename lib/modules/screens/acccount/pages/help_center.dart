import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/widgets/custom_button.dart';
import 'package:graduation_project/widgets/message/messages_methods.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenter extends StatelessWidget {
  static const String routeName = "HelpCenter";
  const HelpCenter({super.key});

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
          "Help Center",
          style: GoogleFonts.merriweather(
            color: const Color(0xFF000000),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/help_center_logo.png"),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "If you have any problems or questions\nPlease contact us.",
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: CustomButton(
                  buttonText: "Contact Us",
                  onPressed: () async {
                    const whatsappUrl = "https://wa.me/201150101928";
              
                    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                      await launchUrl(Uri.parse(whatsappUrl));
                    } else {
                      showErrorMessage(
                          context, "WhatsApp is not installed on your device");
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
