import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://img.freepik.com/free-icon/twitter_318-566762.jpg?t=st=1692588815~exp=1692589415~hmac=342eb508458c67ee247ad149651ba1f6245709f4b8a1163e44c98a6efadd4bcb",
      width: 30,
      height: 30,
    );
  }
}
