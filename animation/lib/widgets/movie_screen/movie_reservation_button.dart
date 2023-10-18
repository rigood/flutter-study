import 'package:flutter/material.dart';
import 'package:animation/constants/colors.dart';

class MovieReservationButton extends StatelessWidget {
  const MovieReservationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              ColorThemes.primary1,
              ColorThemes.primary2,
            ],
          ),
        ),
        child: const Text(
          "예매하기",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
