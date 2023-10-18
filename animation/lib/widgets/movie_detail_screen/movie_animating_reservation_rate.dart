import 'package:flutter/material.dart';

class MovieAnimatingReservationRate extends StatelessWidget {
  final bool isAnimating;
  final double reservationRate;

  const MovieAnimatingReservationRate({
    super.key,
    required this.isAnimating,
    required this.reservationRate,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(
        begin: 0.0,
        end: isAnimating ? reservationRate : 0,
      ),
      duration: const Duration(seconds: 2),
      builder: (context, value, child) {
        return Text(
          "예매율 ${value.toStringAsFixed(1)}%",
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
