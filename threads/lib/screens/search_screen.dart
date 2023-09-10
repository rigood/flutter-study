import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/mock.dart';
import 'package:threads/widgets/search_list_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.v10,
            CupertinoSearchTextField(
              controller: _textEditingController,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 9,
        itemBuilder: (context, index) {
          return SearchListItem(
            userAvatar: mockData[index % 3]["userAvatar"],
            userName: mockData[index % 3]["userName"],
            userSubname: mockData[index % 3]["userSubname"],
            followers: mockData[index % 3]["followers"],
            hasFollowersAvatar: mockData[index % 3]["hasFollowersAvatar"],
          );
        },
      ),
    );
  }
}
