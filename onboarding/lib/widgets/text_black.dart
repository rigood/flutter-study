import 'package:flutter/material.dart';

class TextBlack extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final Color? color;

  const TextBlack({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.height,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }
}
