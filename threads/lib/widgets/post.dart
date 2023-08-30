import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/constants/sizes.dart';
import 'package:threads/widgets/author_avatar.dart';
import 'package:threads/widgets/replies_avatar.dart';

typedef ListOfImage = List<Map<String, String>>;

class Post extends StatelessWidget {
  const Post({
    super.key,
    required this.authorAvatar,
    required this.authorName,
    required this.readingTime,
    this.postText,
    this.imageList,
    required this.repliesAvatarList,
    required this.replies,
    required this.likes,
    this.isLastPost = false,
  });

  final String authorAvatar, authorName, readingTime;
  final String? postText;
  final ListOfImage? imageList;
  final int replies, likes;
  final ListOfImage repliesAvatarList;
  final bool? isLastPost;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size2,
        horizontal: Sizes.size12,
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
                    Gaps.v5,
                    RepliesAvatar(
                      repliesAvatarList: repliesAvatarList,
                    ),
                  ],
                ),
                Gaps.h10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
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
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            Gaps.h12,
                            const FaIcon(
                              FontAwesomeIcons.ellipsis,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      if (postText != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                postText ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                            ],
                          ),
                        ),
                      if (imageList != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 160,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: imageList?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image:
                                        AssetImage(imageList![index]["img"]!),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Gaps.h10;
                              },
                            ),
                          ),
                        ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Icon(icon: FontAwesomeIcons.heart),
                            Gaps.h12,
                            Icon(icon: FontAwesomeIcons.comment),
                            Gaps.h12,
                            Icon(icon: FontAwesomeIcons.repeat),
                            Gaps.h12,
                            Icon(icon: FontAwesomeIcons.paperPlane),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "$replies replies · $likes likes",
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Gaps.v8,
          if (isLastPost == false)
            Divider(
              thickness: 1,
              color: Colors.grey.withOpacity(0.3),
            ),
        ],
      ),
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
