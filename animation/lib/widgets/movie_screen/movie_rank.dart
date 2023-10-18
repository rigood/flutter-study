import 'package:flutter/material.dart';

class MovieRank extends StatelessWidget {
  final int rank;

  const MovieRank({
    super.key,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -16,
      left: 4,
      child: Text(
        "$rank",
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 56,
          fontStyle: FontStyle.italic,
          fontFamily: "OA",
        ),
      ),
    );
  }
}
