import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/sizes.dart';

class AuthorAvatar extends StatelessWidget {
  const AuthorAvatar({
    super.key,
    required this.authorAvatar,
    this.avatarRadius = 16,
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
          radius: avatarRadius,
          backgroundColor: Colors.grey,
          backgroundImage:
              authorAvatar.isNotEmpty ? AssetImage(authorAvatar) : null,
        ),
        Positioned(
          width: avatarRadius! - 1,
          height: avatarRadius! - 1,
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: avatarRadius! / 2,
            child: CircleAvatar(
              backgroundColor: iconBackgroundColor,
              radius: avatarRadius! / 2 - Sizes.size2,
              child: FaIcon(
                icon,
                size: avatarRadius! / 2,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
