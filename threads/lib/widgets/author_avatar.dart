import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthorAvatar extends StatelessWidget {
  const AuthorAvatar({
    super.key,
    required this.authorAvatar,
  });

  final String authorAvatar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(authorAvatar),
        ),
        Positioned(
          bottom: -2,
          right: -2,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: const FaIcon(
              FontAwesomeIcons.plus,
              size: 10,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
