import 'package:flutter/material.dart';

class MovieRating extends StatelessWidget {
  final Color color;
  final String rating;

  const MovieRating({
    super.key,
    required this.color,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            rating,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              fontFamily: "PretendardSemibold",
            ),
          ),
        ),
      ),
    );
  }
}
