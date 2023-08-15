import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            'assets/images/cocomong.jpg',
          ),
          radius: 25,
        ),
        Text(
          '+',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
