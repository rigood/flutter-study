import 'package:flutter/material.dart';

class TextBlack extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;

  const TextBlack({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
