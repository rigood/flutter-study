import 'package:animation/widgets/heart_animation_widget.dart';
import 'package:flutter/material.dart';

class MovieHeart extends StatelessWidget {
  final bool isAnimating;
  final VoidCallback onEnd;

  const MovieHeart({
    super.key,
    required this.isAnimating,
    required this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Opacity(
        opacity: isAnimating ? 1 : 0,
        child: HeartAnimationWidget(
          isAnimating: isAnimating,
          duration: const Duration(
            milliseconds: 700,
          ),
          onEnd: onEnd,
          child: const Icon(
            Icons.favorite,
            size: 80,
            color: Color(0xffED3124),
          ),
        ),
      ),
    );
  }
}
