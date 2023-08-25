import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboarding/features/auth/confirmation_code_screen.dart';
import 'package:onboarding/features/auth/create_account_screen.dart';
import 'package:onboarding/features/auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OnBoarding',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: Colors.white,
          primary: const Color(0xff3399FF),
          secondary: const Color(0xff66cc99),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            )),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      home: const ConfirmationCodeScreen(),
    );
  }
}
