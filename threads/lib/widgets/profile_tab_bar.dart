import 'package:flutter/material.dart';
import 'package:threads/constants/utils.dart';

class ProfileTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: TabBar(
        indicatorColor: Colors.black,
        labelPadding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        unselectedLabelColor: Colors.grey,
        tabs: [
          Text(
            "Threads",
            style: TextStyle(
              color: isDarkMode(context) ? Colors.white : Colors.black,
            ),
          ),
          Text(
            "Replies",
            style: TextStyle(
              color: isDarkMode(context) ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 38;

  @override
  double get minExtent => 38;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
