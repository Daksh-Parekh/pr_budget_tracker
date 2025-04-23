import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pr_budget_tracker/screens/home_page.dart';
import 'package:pr_budget_tracker/screens/splash_screen.dart';

class AppRoutes {
  static String splash = '/';
  static String home = '/home_page';

  static List<GetPage> getPage = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: home, page: () => HomePage()),
  ];
}
