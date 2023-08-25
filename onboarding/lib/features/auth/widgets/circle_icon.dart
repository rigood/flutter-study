import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return FaIcon(
      FontAwesomeIcons.solidCircleCheck,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
