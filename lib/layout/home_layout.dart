import 'package:flutter/material.dart';

import 'package:graduation_project/layout/provider/app_provider.dart';

import 'package:graduation_project/widgets/bottom_nav.dart';

import 'package:provider/provider.dart';



class HomeLayout extends StatelessWidget {
  static const String routeName = "HomeLayout";

  const HomeLayout({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);

    return Scaffold(
      

      backgroundColor: Colors.white,

      body: PageView(
        controller: provider.pageController,
        onPageChanged: (value) {
          provider.onPageChanged(value);
        },
        children: provider.tabs,
      ),
      bottomNavigationBar: const BuildBottomNavigation(),

      // BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: primaryColor,
      //   unselectedItemColor: Colors.grey,
      //   currentIndex: provider.selectedTabIndex,
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home_outlined), label: "Home"),
      //     BottomNavigationBarItem(icon: Icon(Icons.person_2), label: "Profile"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.settings), label: "Settings"),
      //   ],
      //   onTap: (value) {
      //     provider.changeBottomNav(value);
      //   },
      // ),
    );
  }
}
