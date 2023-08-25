import 'package:flutter/material.dart';

class TextPrimary extends StatelessWidget {
  final String text;
  final double? fontSize;

  const TextPrimary({
    super.key,
    required this.text,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: fontSize,
      ),
    );
  }
}
