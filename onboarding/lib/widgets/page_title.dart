import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String text;
  final double? fontSize;

  const PageTitle({
    super.key,
    required this.text,
    this.fontSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
