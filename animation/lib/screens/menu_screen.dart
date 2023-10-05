import 'package:flutter/material.dart';
import 'package:animation/screens/implicit_animations_screen.dart';
import 'package:animation/screens/explicit_animations_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("플러터 애니메이션 연습"),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => _goToPage(
                  context,
                  const ImplicitAnimationsScreen(),
                ),
                child: const Text("Implicit Animation"),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(
                  context,
                  const ExplicitAnimationsScreen(),
                ),
                child: const Text("Explicit Animation"),
              ),
            ],
          ),
        ));
  }
}
