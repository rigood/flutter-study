import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onUpIconTap;

  const CustomAppBar({
    super.key,
    required this.onUpIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.chevron_left,
          color: Colors.white.withOpacity(0.5),
          size: 28,
        ),
      ),
      title: IconButton(
        onPressed: onUpIconTap,
        icon: Icon(
          Icons.keyboard_double_arrow_up,
          color: Colors.white.withOpacity(0.8),
          size: 28,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
