import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt navIndex = 1.obs;
  PageController pageController = PageController(initialPage: 1);
  void changeNavIndex(int index) {
    navIndex.value = index;
  }

  void changePageIndex(int index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    update();
  }
}
