import 'package:flutter/material.dart';
import 'package:onboarding/constants/sizes.dart';

typedef OnTapFunction = void Function();

class BottomButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final OnTapFunction onTap;
  final Color? activeColor;
  final double? width;

  const BottomButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.onTap,
    this.activeColor = Colors.black,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size12,
          horizontal: Sizes.size24,
        ),
        decoration: BoxDecoration(
          color: isActive ? activeColor : Colors.grey,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
