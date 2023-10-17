import 'dart:ui';
import 'package:flutter/material.dart';

class PosterBlurBackground extends StatelessWidget {
  final int index;

  const PosterBlurBackground({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(index),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/covers/${index + 1}.jpg"),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          color: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }
}
