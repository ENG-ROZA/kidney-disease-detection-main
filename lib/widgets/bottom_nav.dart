import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:graduation_project/layout/provider/app_provider.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:provider/provider.dart';

class BuildBottomNavigation extends StatelessWidget {
  const BuildBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        // border: Border(
        //   top: BorderSide(
        //     color: const Color(0xFF2949C7).withOpacity(0.25),
        //   ),
        // ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.4),
        //     offset: const Offset(0, 20),
        //     blurRadius: 30,
        //   )
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: GNav(
            curve: Curves.easeInToLinear,
            gap: 8.0,
            color: primaryColor,
            activeColor: primaryColor,
            tabActiveBorder: Border.all(color: Colors.black, width: 2),
            haptic: true,
            padding: const EdgeInsets.all(16.0),
            selectedIndex: provider.selectedTabIndex,
            onTabChange: (value) {
              provider.changeBottomNav(value);
            },
            tabs: [
              GButton(
                  icon: Icons.home,
                  iconColor: const Color(0xFF7f7b7c),
                  iconActiveColor: Colors.black,
                  text: "Home",
                  textStyle: GoogleFonts.crimsonText(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              GButton(
                  icon: Icons.history_sharp,
                  iconColor: const Color(0xFF7f7b7c),
                  iconActiveColor: Colors.black,
                  text: "History",
                  textStyle: GoogleFonts.crimsonText(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              GButton(
                  icon: Icons.chat,
                  iconColor: const Color(0xFF7f7b7c),
                  iconActiveColor: Colors.black,
                  text: "Chat",
                  textStyle: GoogleFonts.crimsonText(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              GButton(
                  icon: Icons.person,
                  iconSize: 25,
                  iconColor: const Color(0xFF7f7b7c),
                  iconActiveColor: Colors.black,
                  text: "Profile",
                  textStyle: GoogleFonts.crimsonText(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ]),
      ),
    );
  }
}
