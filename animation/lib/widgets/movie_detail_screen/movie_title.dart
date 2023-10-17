import 'package:flutter/material.dart';

class MovieTitle extends StatelessWidget {
  final String title;

  const MovieTitle({
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
