import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pr_budget_tracker/utils/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppRoutes.getPage,
      theme: ThemeData(
        // colorSchemeSeed: Color(0xff1937FE),
        scaffoldBackgroundColor: Color(0xff1937FE).withOpacity(0.5),
        appBarTheme: AppBarTheme(
          // color: Color(0xff1937FE).withOpacity(0.4),
          backgroundColor: const Color(0xff1937FE).withOpacity(0.7),
          elevation: 5,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          centerTitle: true,
        ),
      ),
      themeMode: ThemeMode.system,
    );
  }
}
