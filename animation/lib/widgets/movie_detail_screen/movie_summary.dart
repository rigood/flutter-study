import 'package:flutter/material.dart';

class MovieSummary extends StatelessWidget {
  final String summary;

  const MovieSummary({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      summary,
      style: TextStyle(
        fontFamily: "PretendardLight",
        fontSize: 14,
        color: Colors.white.withOpacity(0.8),
        height: 1.7,
        letterSpacing: -0.2,
      ),
    );
  }
}
