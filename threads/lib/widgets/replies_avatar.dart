import 'package:flutter/material.dart';
import 'package:threads/utils.dart';

class RepliesAvatar extends StatelessWidget {
  const RepliesAvatar({
    super.key,
    required this.repliesAvatarList,
  });

  final List<String> repliesAvatarList;

  @override
  Widget build(BuildContext context) {
    if (repliesAvatarList.length >= 3) {
      return ThreeAvatars(repliesAvatarList: repliesAvatarList);
    } else if (repliesAvatarList.length >= 2) {
      return TwoAvatars(repliesAvatarList: repliesAvatarList);
    } else if (repliesAvatarList.length == 1) {
      return OneAvatar(repliesAvatarList: repliesAvatarList);
    } else {
      return const SizedBox(
        width: 40,
        height: 40,
      );
    }
  }
}

class OneAvatar extends StatelessWidget {
  const OneAvatar({
    super.key,
    required this.repliesAvatarList,
  });

  final List<String> repliesAvatarList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
          width: 40,
          height: 40,
        ),
        Positioned(
          top: 8,
          left: 8,
          child: CircleAvatar(
            radius: 12,
            backgroundImage: repliesAvatarList[0].startsWith("https")
                ? NetworkImage(repliesAvatarList[0])
                : AssetImage(repliesAvatarList[0]) as ImageProvider,
          ),
        )
      ],
    );
  }
}

class TwoAvatars extends StatelessWidget {
  const TwoAvatars({
    super.key,
    required this.repliesAvatarList,
  });

  final List<String> repliesAvatarList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
          width: 40,
          height: 40,
        ),
        Positioned(
          top: 10,
          child: CircleAvatar(
            radius: 10,
            backgroundImage: repliesAvatarList[0].startsWith("https")
                ? NetworkImage(repliesAvatarList[0])
                : AssetImage(repliesAvatarList[0]) as ImageProvider,
          ),
        ),
        Positioned(
          top: 7,
          left: 17,
          child: CircleAvatar(
            radius: 13,
            backgroundColor: isDarkMode(context) ? Colors.black : Colors.white,
            child: CircleAvatar(
              radius: 10,
              backgroundImage: repliesAvatarList[1].startsWith("https")
                  ? NetworkImage(repliesAvatarList[1])
                  : AssetImage(repliesAvatarList[1]) as ImageProvider,
            ),
          ),
        ),
      ],
    );
  }
}

class ThreeAvatars extends StatelessWidget {
  const ThreeAvatars({
    super.key,
    required this.repliesAvatarList,
  });

  final List<String> repliesAvatarList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
          width: 40,
          height: 40,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
            radius: 11,
            backgroundColor: Colors.grey.shade300,
            child: CircleAvatar(
              radius: 10,
              backgroundImage: repliesAvatarList[0].startsWith("https")
                  ? NetworkImage(repliesAvatarList[0])
                  : AssetImage(repliesAvatarList[0]) as ImageProvider,
            ),
          ),
        ),
        Positioned(
          top: 17.5,
          left: 0,
          child: CircleAvatar(
            radius: 9,
            backgroundColor: Colors.grey.shade300,
            child: CircleAvatar(
              radius: 8,
              backgroundImage: repliesAvatarList[1].startsWith("https")
                  ? NetworkImage(repliesAvatarList[1])
                  : AssetImage(repliesAvatarList[1]) as ImageProvider,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 20,
          child: CircleAvatar(
            radius: 7,
            backgroundColor: Colors.grey.shade300,
            child: CircleAvatar(
              radius: 6,
              backgroundImage: repliesAvatarList[2].startsWith("https")
                  ? NetworkImage(repliesAvatarList[2])
                  : AssetImage(repliesAvatarList[2]) as ImageProvider,
            ),
          ),
        ),
      ],
    );
  }
}
