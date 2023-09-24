import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/constants/sizes.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/view_models/post_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:threads/widgets/post.dart';
import 'package:threads/utils.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  static String routeName = "search";

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  void _onSearchChanged(String query) {
    ref.watch(postProvider.notifier).searchPosts(query);
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Gaps.v10,
            CupertinoSearchTextField(
              controller: _textEditingController,
              onChanged: _onSearchChanged,
              suffixMode: OverlayVisibilityMode.editing,
              style: TextStyle(
                color: isDarkMode(context) ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: _hideKeyboard,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ref.watch(postProvider).when(
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
                          readingTime:
                              getPostReadingTime(posts[index].text.length),
                          postText: posts[index].text,
                          postImageList: [posts[index].imgUrl],
                          repliesAvatarList: const [],
                          replies: posts[index].replies,
                          likes: posts[index].likes,
                          onEllipsisTap: () {},
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.size3,
                          ),
                          child: Divider(
                            thickness: 1,
                          ),
                        );
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
