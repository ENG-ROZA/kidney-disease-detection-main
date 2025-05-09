import 'package:flutter/material.dart';
import 'package:graduation_project/modules/bot/bot_screen.dart';

import 'package:graduation_project/modules/screens/history/history.dart';
import 'package:graduation_project/modules/screens/home/home_screen.dart';
import 'package:graduation_project/modules/screens/profile/profile.dart';

class AppProvider extends ChangeNotifier {
  int selectedTabIndex = 0;
  bool _isHidden = true;
  bool hasError = false;
  bool skeltonLoading = true;
  bool get isHidden => _isHidden;
  late TextEditingController verifyEmailController = TextEditingController();
  final List<Widget> tabs = [
    const HomeScreen(),
    const History(),
     const BotScreen(),
    Profile(),
  
  ];
  final PageController pageController = PageController();

  void changeBottomNav(int index) {
    selectedTabIndex = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn);
    notifyListeners();
  }

  void toggleObscureText(bool currentIsHidden) {
    _isHidden = !currentIsHidden;
    notifyListeners();
  }

  void onPageChanged(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }

  void showSuffixIconInError({required bool ishasError}) {
    hasError = ishasError;
    notifyListeners();
  }

  bool changeSkeltonizer() {
    skeltonLoading = false;
    notifyListeners();
    return skeltonLoading;
  }

  void resetTabIndex() {
    selectedTabIndex = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
