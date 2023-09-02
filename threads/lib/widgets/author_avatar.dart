import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthorAvatar extends StatelessWidget {
  const AuthorAvatar({
    super.key,
    required this.authorAvatar,
    this.avatarRadius = 20,
    this.icon = FontAwesomeIcons.plus,
    this.iconBackgroundColor = Colors.black,
  });

  final String authorAvatar;
  final double? avatarRadius;
  final IconData? icon;
  final Color? iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: avatarRadius ?? 20,
          backgroundImage: AssetImage(authorAvatar),
        ),
        Positioned(
          bottom: -3,
          right: -3,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: FaIcon(
              icon,
              size: 10,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
