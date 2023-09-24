import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/constants/sizes.dart';
import 'package:threads/widgets/author_avatar.dart';
import 'package:threads/widgets/replies_avatar.dart';

typedef ListOfImgUrl = List<String>;

class Post extends StatelessWidget {
  const Post({
    super.key,
    required this.authorAvatar,
    required this.authorName,
    required this.readingTime,
    required this.postText,
    required this.postImageList,
    required this.repliesAvatarList,
    required this.replies,
    required this.likes,
    required this.onEllipsisTap,
  });

  final String authorAvatar;
  final String authorName;
  final String readingTime;
  final String postText;
  final ListOfImgUrl postImageList;
  final ListOfImgUrl repliesAvatarList;
  final int replies;
  final int likes;
  final Function onEllipsisTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size12,
        vertical: Sizes.size12,
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Column(
                  children: [
                    AuthorAvatar(
                      authorAvatar: authorAvatar,
                    ),
                    Gaps.v5,
                    Expanded(
                      child: VerticalDivider(
                        color: Colors.grey.withOpacity(0.3),
                        thickness: 2,
                      ),
                    ),
                    if (repliesAvatarList.isNotEmpty)
                      RepliesAvatar(
                        repliesAvatarList: repliesAvatarList,
                      )
                  ],
                ),
                Gaps.h10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                          authorName: authorName,
                          readingTime: readingTime,
                          onEllipsisTap: onEllipsisTap),
                      Gaps.v2,
                      if (postText.isNotEmpty) BodyText(postText: postText),
                      if (postImageList.isNotEmpty) Gaps.v12,
                      if (postImageList.isNotEmpty)
                        ImageSlider(imageList: postImageList),
                      Gaps.v12,
                      const Icons(),
                      Gaps.v12,
                      RepliesAndLikes(replies: replies, likes: likes),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.authorName,
    required this.readingTime,
    required this.onEllipsisTap,
  });

  final String authorName;
  final String readingTime;
  final Function onEllipsisTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            authorName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gaps.h12,
        Text(
          readingTime,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Gaps.h12,
        GestureDetector(
          onTap: () => onEllipsisTap(),
          child: const FaIcon(
            FontAwesomeIcons.ellipsis,
            size: 16,
          ),
        ),
      ],
    );
  }
}

class BodyText extends StatelessWidget {
  const BodyText({
    super.key,
    required this.postText,
  });

  final String? postText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(postText!),
        ),
      ],
    );
  }
}

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.imageList,
  });

  final ListOfImgUrl imageList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: NetworkImage(imageList[index]),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Gaps.h12;
        },
      ),
    );
  }
}

class Icons extends StatelessWidget {
  const Icons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(icon: FontAwesomeIcons.heart),
        Gaps.h12,
        Icon(icon: FontAwesomeIcons.comment),
        Gaps.h12,
        Icon(icon: FontAwesomeIcons.repeat),
        Gaps.h12,
        Icon(icon: FontAwesomeIcons.paperPlane),
      ],
    );
  }
}

class RepliesAndLikes extends StatelessWidget {
  const RepliesAndLikes({
    super.key,
    required this.replies,
    required this.likes,
  });

  final int replies;
  final int likes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$replies replies · $likes likes",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

class Icon extends StatelessWidget {
  final IconData icon;

  const Icon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      icon,
      size: 18,
    );
  }
}
