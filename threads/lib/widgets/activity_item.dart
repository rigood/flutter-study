import 'package:flutter/material.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/utils.dart';
import 'package:threads/widgets/author_avatar.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem({
    super.key,
    required this.userAvatar,
    required this.icon,
    required this.iconBackgroundColor,
    required this.userName,
    required this.hours,
    required this.activity,
    required this.activityMessage,
    required this.activityDescription,
  });

  final String userAvatar;
  final IconData icon;
  final Color iconBackgroundColor;
  final String userName;
  final int hours;
  final String activity, activityMessage, activityDescription;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: AuthorAvatar(
          authorAvatar: userAvatar,
          avatarRadius: 16,
          icon: icon,
          iconBackgroundColor: iconBackgroundColor,
        ),
        minLeadingWidth: 0,
        titleAlignment: ListTileTitleAlignment.top,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gaps.h5,
                          Text(
                            "${hours}h",
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode(context)
                                  ? Colors.grey.shade600
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Gaps.v4,
                      Text(
                        activityMessage,
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.grey.shade600
                              : Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                if (activity == "Following")
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 18,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Following",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 6,
                bottom: 12,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
              ),
              child: Row(
                children: [
                  if (activityDescription != "")
                    Expanded(
                      child: Text(
                        activityDescription,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ));
  }
}
