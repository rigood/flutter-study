import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/constants/utils.dart';
import 'package:threads/screens/settings_screen.dart';
import 'package:threads/widgets/post.dart';
import 'package:threads/widgets/profile_tab_bar.dart';
import 'package:threads/widgets/replies_avatar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final imageList2 = [
    {
      "img": "assets/images/1.jpg",
    },
    {
      "img": "assets/images/2.jpg",
    },
  ];

  void _onSettingsTap() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              toolbarHeight: 50,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.globe,
                    size: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const FaIcon(FontAwesomeIcons.instagram),
                      Gaps.h20,
                      GestureDetector(
                        onTap: _onSettingsTap,
                        child: const FaIcon(
                          FontAwesomeIcons.barsStaggered,
                          size: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.v10,
                            const Text(
                              "Jane",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gaps.v5,
                            Row(
                              children: [
                                const Text("jane_mobbin"),
                                Gaps.h5,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isDarkMode(context)
                                        ? Colors.grey.shade900
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    "threads.net",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const CircleAvatar(
                          radius: 28,
                          backgroundImage:
                              AssetImage("assets/images/cocomong.jpg"),
                        )
                      ],
                    ),
                    Gaps.v10,
                    const Text("Planet enthusiast!"),
                    Gaps.v10,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RepliesAvatar(
                          repliesAvatarList: imageList2,
                        ),
                        Gaps.h10,
                        const Text(
                          "2 followers",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Gaps.v10,
                    const Row(
                      children: [
                        ProfileButton(
                          text: "Edit profile",
                        ),
                        Gaps.h10,
                        ProfileButton(
                          text: "Share profile",
                        ),
                      ],
                    ),
                    Gaps.v10,
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: ProfileTabBar(),
              pinned: true,
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: TabBarView(
            children: [
              ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Post(
                    authorAvatar: "assets/images/cocomong.jpg",
                    authorName: "Cocomong",
                    readingTime: "6m",
                    postText: "I like his songs.",
                    imageList: imageList2,
                    repliesAvatarList: imageList2,
                    replies: 36,
                    likes: 391,
                    onEllipsisTap: () {},
                  );
                },
              ),
              ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Post(
                    authorAvatar: "assets/images/1.jpg",
                    authorName: "Jin",
                    readingTime: "1m",
                    postText: "Look at him kkkk",
                    repliesAvatarList: imageList2,
                    replies: 55,
                    likes: 185,
                    onEllipsisTap: () {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class ProfileButton extends StatelessWidget {
  final String text;

  const ProfileButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
              child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          )),
        ));
  }
}
