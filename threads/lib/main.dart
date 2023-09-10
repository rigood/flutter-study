import 'package:flutter/material.dart';
import 'package:threads/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Threads",
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.black,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
