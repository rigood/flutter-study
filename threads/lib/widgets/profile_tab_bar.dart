import 'package:flutter/material.dart';

class ProfileTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: const TabBar(
        indicatorColor: Colors.black,
        labelPadding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        unselectedLabelColor: Colors.grey,
        tabs: [
          Text(
            "Threads",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          Text(
            "Replies",
            style: TextStyle(
              color: Colors.black,
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
