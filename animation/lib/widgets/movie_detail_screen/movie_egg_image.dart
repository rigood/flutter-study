import 'package:flutter/material.dart';

class MovieEggImage extends StatelessWidget {
  final String eggImagePath;

  const MovieEggImage({
    super.key,
    required this.eggImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      eggImagePath,
      width: 20,
      height: 20,
    );
  }
}
