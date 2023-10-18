import 'package:animation/widgets/heart_animation_widget.dart';
import 'package:flutter/material.dart';

class MovieLikeButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onTap;

  const MovieLikeButton({
    super.key,
    required this.isLiked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: HeartAnimationWidget(
        isAnimating: isLiked,
        alwaysAnimate: true,
        child: IconButton(
          onPressed: onTap,
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_outline,
            color: isLiked ? Colors.red : Colors.white,
          ),
        ),
      ),
    );
  }
}
