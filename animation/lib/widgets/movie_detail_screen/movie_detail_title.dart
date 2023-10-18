import 'package:flutter/material.dart';

class MovieDetailTitle extends StatelessWidget {
  final String title;

  const MovieDetailTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: "OA",
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: Colors.white,
        letterSpacing: -1,
      ),
    );
  }
}
