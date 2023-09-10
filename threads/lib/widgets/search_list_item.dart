import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/constants/utils.dart';

class SearchListItem extends StatelessWidget {
  const SearchListItem(
      {super.key,
      required this.userAvatar,
      required this.userName,
      required this.userSubname,
      required this.followers,
      required this.hasFollowersAvatar});

  final String userAvatar;
  final String userName, userSubname;
  final String followers;
  final bool hasFollowersAvatar;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage(userAvatar),
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
                          Gaps.h2,
                          const FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
                            size: 12,
                            color: Color(0xff3399FF),
                          ),
                        ],
                      ),
                      Gaps.v4,
                      Text(
                        userSubname,
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Follow",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
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
                  if (hasFollowersAvatar)
                    const CircleAvatar(
                      radius: 8,
                      backgroundImage: AssetImage("assets/images/cocomong.jpg"),
                    ),
                  if (hasFollowersAvatar) Gaps.h8,
                  Text(
                    '$followers follwers',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
