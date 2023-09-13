import 'package:flutter/material.dart';
import 'package:threads/constants/sizes.dart';
import 'package:threads/constants/utils.dart';
import 'package:threads/widgets/bottom_sheet.dart';
import 'package:threads/widgets/post.dart';

class PostScreen extends StatelessWidget {
  static String routeName = "";

  PostScreen({super.key});

  final imageList1 = [
    {"img": "assets/images/blue.gif"}
  ];

  final imageList2 = [
    {
      "img": "assets/images/1.jpg",
    },
    {
      "img": "assets/images/2.jpg",
    },
  ];

  final imageList3 = [
    {
      "img": "assets/images/1.jpg",
    },
    {
      "img": "assets/images/2.jpg",
    },
    {
      "img": "assets/images/3.png",
    },
  ];

  void _onEllipsisTap(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const CustomBottomSheet(),
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.75),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Logo(),
          Post(
            authorAvatar: "assets/images/cocomong.jpg",
            authorName: "Cocomong",
            readingTime: "6m",
            postText: "I like his songs.",
            imageList: imageList2,
            repliesAvatarList: imageList3,
            replies: 36,
            likes: 391,
            onEllipsisTap: () => _onEllipsisTap(context),
          ),
          Post(
            authorAvatar: "assets/images/3.png",
            authorName: "Jin",
            readingTime: "1m",
            postText: "Look at him kkkk",
            imageList: imageList1,
            repliesAvatarList: imageList2,
            replies: 55,
            likes: 185,
            onEllipsisTap: () => _onEllipsisTap(context),
          ),
          Post(
            authorAvatar: "assets/images/logo.png",
            authorName: "Threads",
            readingTime: "1m",
            postText: "Welcome to Threads",
            repliesAvatarList: imageList3,
            replies: 99,
            likes: 999,
            isLastPost: true,
            onEllipsisTap: () => _onEllipsisTap(context),
          ),
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 50,
        bottom: 20,
      ),
      child: Image(
        image: AssetImage(isDarkMode(context)
            ? "assets/images/logo_dark.png"
            : "assets/images/logo.png"),
        width: Sizes.size32,
      ),
    );
  }
}
