import 'dart:math';

import 'package:flutter/material.dart';

class ImplicitAnimationsChallenge extends StatefulWidget {
  const ImplicitAnimationsChallenge({super.key});

  @override
  State<ImplicitAnimationsChallenge> createState() =>
      _ImplicitAnimationsChallengeState();
}

class _ImplicitAnimationsChallengeState
    extends State<ImplicitAnimationsChallenge> {
  Color getColorByIndex(int index) {
    if (index % 2 == 0) {
      if (index % 20 < 10) {
        return const Color(0xffFEAD13);
      } else {
        return const Color(0xff20A0AA);
      }
    } else {
      if (index % 20 < 10) {
        return const Color(0xffF14139);
      } else {
        return const Color(0xffDFDFC4);
      }
    }
  }

  final double _begin = Random().nextDouble();
  double _end = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Implicit Animations",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        child: TweenAnimationBuilder(
          tween: Tween(begin: _begin, end: _end),
          curve: Curves.easeOut,
          duration: const Duration(seconds: 1),
          onEnd: () {
            setState(() {
              _end = _end == 1.0 ? -1.0 : 1.0;
            });
          },
          builder: (context, value, child) {
            return GridView.builder(
              itemCount: 100,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final quotient = (index / 10).floor();
                final remainder = index % 10;
                final weightX = (remainder - 5.0).abs();
                final weightY = (quotient - 5.0).abs() / 5;
                final newValue = weightX * weightY * value;

                final newX = newValue;
                final newY = (remainder > 6 && quotient < 5) ||
                        (remainder < 6 && quotient > 5)
                    ? -newValue
                    : newValue;

                return Container(
                  transform: Matrix4.skew(newValue * 0.02, newY * 0.04)
                    ..translate(newX, newY),
                  decoration: BoxDecoration(
                    color: getColorByIndex(index),
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
