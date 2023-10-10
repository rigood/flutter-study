import 'package:animation/screens/implicit_animations_screen.dart';
import 'package:flutter/material.dart';
import 'package:animation/screens/implicit_animations_challenge.dart';
import 'package:animation/screens/explicit_animations_screen.dart';
import 'package:animation/screens/explicit_animations_challenge.dart';
import 'package:animation/screens/apple_watch_screen.dart';
import 'package:animation/screens/pomodoro_screen.dart';
import 'package:animation/screens/swiping_cards_screen.dart';
import 'package:animation/screens/flashcards_screen.dart';

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
          title: const Text(
            "플러터 애니메이션 연습",
          ),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => _goToPage(
                  context,
                  const ImplicitAnimationsScreen(),
                ),
                child: const Text("Implicit Animations"),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(
                  context,
                  const ImplicitAnimationsChallenge(),
                ),
                child: const Text("Implicit Animations Challenge"),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(
                  context,
                  const ExplicitAnimationsScreen(),
                ),
                child: const Text("Explicit Animations"),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(
                  context,
                  const ExplicitAnimationsChallenge(),
                ),
                child: const Text("Explicit Animations Challenge"),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(
                  context,
                  const AppleWatchScreen(),
                ),
                child: const Text("Apple Watch"),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(
                  context,
                  const PomodoroScreen(),
                ),
                child: const Text("Pomodoro"),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(
                  context,
                  const SwipingCardsScreen(),
                ),
                child: const Text("Swiping Cards"),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(
                  context,
                  const FlashCardsScreen(),
                ),
                child: const Text("Flashcards"),
              ),
            ],
          ),
        ));
  }
}
