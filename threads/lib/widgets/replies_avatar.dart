import 'package:flutter/material.dart';
import 'package:threads/constants/utils.dart';

class RepliesAvatar extends StatelessWidget {
  const RepliesAvatar({
    super.key,
    required this.repliesAvatarList,
  });

  final List<Map<String, String>> repliesAvatarList;

  @override
  Widget build(BuildContext context) {
    return (repliesAvatarList.length >= 3
        ? Stack(children: [
            const SizedBox(
              width: 40,
              height: 40,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: CircleAvatar(
                radius: 11,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 10,
                  backgroundImage: AssetImage(repliesAvatarList[0]["img"]!),
                ),
              ),
            ),
            Positioned(
              top: 17.5,
              left: 0,
              child: CircleAvatar(
                radius: 9,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 8,
                  backgroundImage: AssetImage(repliesAvatarList[1]["img"]!),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 20,
              child: CircleAvatar(
                radius: 6,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 5,
                  backgroundImage: AssetImage(repliesAvatarList[2]["img"]!),
                ),
              ),
            ),
          ])
        : Stack(
            children: [
              const SizedBox(
                width: 40,
                height: 40,
              ),
              Positioned(
                top: 10,
                child: CircleAvatar(
                  radius: 10,
                  backgroundImage: AssetImage(repliesAvatarList[0]["img"]!),
                ),
              ),
              Positioned(
                top: 7,
                left: 17,
                child: CircleAvatar(
                  radius: 13,
                  backgroundColor:
                      isDarkMode(context) ? Colors.black : Colors.white,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage(repliesAvatarList[1]["img"]!),
                  ),
                ),
              ),
            ],
          ));
  }
}
