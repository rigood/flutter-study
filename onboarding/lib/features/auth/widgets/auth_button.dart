import 'package:flutter/material.dart';
import 'package:onboarding/constants/sizes.dart';
import 'package:onboarding/constants/gaps.dart';

typedef OnTapFunction = void Function();

class AuthButton extends StatelessWidget {
  final bool isInverted;
  final String text;
  final Image? logo;
  final OnTapFunction? onTap;

  const AuthButton(
      {super.key,
      required this.isInverted,
      required this.text,
      this.logo,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.all(
            Sizes.size14,
          ),
          decoration: isInverted
              ? BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(45),
                )
              : BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: Sizes.size1,
                  ),
                  borderRadius: BorderRadius.circular(45),
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (logo != null) logo!,
              if (logo != null) Gaps.h12,
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: isInverted ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
