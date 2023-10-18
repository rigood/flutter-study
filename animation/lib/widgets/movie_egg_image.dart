import 'package:flutter/material.dart';

class MovieEggImage extends StatelessWidget {
  final String eggImagePath;
  final double? size;

  const MovieEggImage({
    super.key,
    required this.eggImagePath,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      eggImagePath,
      width: size,
      height: size,
    );
  }
}
