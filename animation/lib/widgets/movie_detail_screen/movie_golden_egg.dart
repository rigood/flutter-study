import 'package:flutter/material.dart';

class MovieGoldenEgg extends StatelessWidget {
  final bool isAnimating;
  final int goldenEgg;

  const MovieGoldenEgg({
    super.key,
    required this.isAnimating,
    required this.goldenEgg,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(
        begin: 0.0,
        end: isAnimating ? goldenEgg : 0,
      ),
      duration: const Duration(seconds: 2),
      builder: (context, value, child) {
        return Text(
          "${value.ceil().toString()}%",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
