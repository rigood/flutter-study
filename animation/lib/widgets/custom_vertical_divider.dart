import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  final double? height;
  final Color? color;

  const CustomVerticalDivider({
    super.key,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: VerticalDivider(
        color: color,
      ),
    );
  }
}
