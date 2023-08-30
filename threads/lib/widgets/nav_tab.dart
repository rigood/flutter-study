import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/sizes.dart';

class NavTab extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final Function onTap;

  const NavTab({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: AnimatedOpacity(
        opacity: isSelected ? 1 : 0.3,
        duration: const Duration(milliseconds: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              size: Sizes.size20,
            ),
          ],
        ),
      ),
    );
  }
}
