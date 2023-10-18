import 'package:flutter/material.dart';

class MovieGoldenEgg extends StatelessWidget {
  final int goldenEgg;

  const MovieGoldenEgg({
    super.key,
    required this.goldenEgg,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$goldenEgg",
      style: const TextStyle(
        fontFamily: "PretendardMedium",
        fontSize: 12,
        letterSpacing: -0.5,
      ),
    );
  }
}
