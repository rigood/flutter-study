import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/constants/sizes.dart';
import 'package:threads/repos/post_repo.dart';
import 'package:threads/utils.dart';
import 'package:threads/widgets/logo.dart';
import 'package:threads/widgets/post.dart';
import 'package:threads/widgets/custom_bottom_sheet.dart';

class PostScreen extends ConsumerWidget {
  const PostScreen({super.key});

  static String routeName = "";

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
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Logo(),
          ref.watch(postStream).when(
                loading: () => const Padding(
                  padding: EdgeInsets.only(
                    top: Sizes.size48,
                  ),
                  child: Center(
                    child: SizedBox(
                      width: Sizes.size48,
                      height: Sizes.size48,
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ),
                error: (error, stackTrace) => Center(
                  child: Column(
                    children: [
                      const Text("Thread를 불러올 수 없습니다."),
                      Text("$error"),
                    ],
                  ),
                ),
                data: (posts) => ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Post(
                      authorAvatar: posts[index].creatorAvatar,
                      authorName: posts[index].creatorName,
                      readingTime: getPostReadingTime(posts[index].text.length),
                      postText: posts[index].text,
                      postImageList: [posts[index].imgUrl],
                      repliesAvatarList: const [],
                      replies: posts[index].replies,
                      likes: posts[index].likes,
                      onEllipsisTap: () => _onEllipsisTap(context),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.size3,
                      ),
                      child: Divider(
                        height: 0,
                        thickness: 1,
                      ),
                    );
                  },
                ),
              ),
        ],
      ),
    );
  }
}
