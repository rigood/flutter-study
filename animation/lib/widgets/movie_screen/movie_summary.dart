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
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.grey.shade800,
        fontSize: 11.5,
        fontFamily: "PretendardLight",
        letterSpacing: -0.2,
        height: 1.5,
      ),
    );
  }
}
