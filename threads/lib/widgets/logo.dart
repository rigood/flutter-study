import 'package:flutter/material.dart';
import 'package:threads/constants/sizes.dart';
import 'package:threads/utils.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Sizes.size48,
      ),
      child: Image(
        image: AssetImage(isDarkMode(context)
            ? "assets/images/logo/logo_darkmode.png"
            : "assets/images/logo/logo_lightmode.png"),
        width: Sizes.size32,
      ),
    );
  }
}
