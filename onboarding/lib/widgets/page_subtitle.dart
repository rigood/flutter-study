import 'package:flutter/material.dart';

class PageSubtitle extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;

  const PageSubtitle({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black54,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
