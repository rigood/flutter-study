import 'package:flutter/material.dart';
import 'package:onboarding/constants/sizes.dart';
import 'package:onboarding/constants/gaps.dart';
import 'package:onboarding/widgets/app_logo.dart';
import 'package:onboarding/widgets/bottom_button.dart';
import 'package:onboarding/widgets/page_title.dart';
import 'package:onboarding/widgets/page_subtitle.dart';
import 'package:onboarding/widgets/text_black.dart';

const musics1 = [
  "Rap",
  "R&B & Soul",
  "Grammy Awards",
  "Dance",
];

const musics2 = [
  "Pop",
  "K-pop",
  "Music Industry",
  "EDM",
];

const musics3 = [
  "Music news",
  "Hip hop",
  "Reggae",
  "Rock",
];

const entertainments1 = [
  "Anime",
  "Movies & TV",
  "Harry Potter",
  "Squid Game",
];

const entertainments2 = [
  "Marvel Universe",
  "Movie news",
  "Naruto",
  "The glory",
];

const entertainments3 = [
  "Movies",
  "Grammy Awards",
  "Entertainment",
  "TV shows",
];

class InterestsScreenHorizontal extends StatefulWidget {
  const InterestsScreenHorizontal({super.key});

  @override
  State<InterestsScreenHorizontal> createState() =>
      _InterestsScreenHorizontalState();
}

class _InterestsScreenHorizontalState extends State<InterestsScreenHorizontal> {
  int count = 0;

  void onIncreaseCount() {
    setState(() {
      count = count + 1;
    });
  }

  void onDecreaseCount() {
    setState(() {
      count = count - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        centerTitle: true,
        title: const AppLogo(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: Sizes.size10,
                horizontal: Sizes.size24,
              ),
              child: Column(
                children: [
                  PageTitle(text: "What do you want to see on Twitter?"),
                  Gaps.v20,
                  PageSubtitle(
                      text:
                          "Interests are used to personalize your experience and will be visible on your profile."),
                  Gaps.v16,
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size10,
                horizontal: Sizes.size20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: TextBlack(
                      text: "Music",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v20,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (var music in musics1)
                              InterestButton(
                                music: music,
                                onIncreaseCount: onIncreaseCount,
                                onDecreaseCount: onDecreaseCount,
                              ),
                          ],
                        ),
                        Gaps.v10,
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (var music in musics2)
                              InterestButton(
                                music: music,
                                onIncreaseCount: onIncreaseCount,
                                onDecreaseCount: onDecreaseCount,
                              ),
                          ],
                        ),
                        Gaps.v10,
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (var music in musics3)
                              InterestButton(
                                music: music,
                                onIncreaseCount: onIncreaseCount,
                                onDecreaseCount: onDecreaseCount,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size10,
                horizontal: Sizes.size20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: TextBlack(
                      text: "Entertainment",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v20,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (var entertainment in entertainments1)
                              InterestButton(
                                music: entertainment,
                                onIncreaseCount: onIncreaseCount,
                                onDecreaseCount: onDecreaseCount,
                              ),
                          ],
                        ),
                        Gaps.v10,
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (var entertainment in entertainments2)
                              InterestButton(
                                music: entertainment,
                                onIncreaseCount: onIncreaseCount,
                                onDecreaseCount: onDecreaseCount,
                              ),
                          ],
                        ),
                        Gaps.v10,
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (var entertainment in entertainments3)
                              InterestButton(
                                music: entertainment,
                                onIncreaseCount: onIncreaseCount,
                                onDecreaseCount: onDecreaseCount,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
            color: Colors.grey.withOpacity(0.3),
          ))),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size12,
              horizontal: Sizes.size32,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(""),
                BottomButton(
                    text: "Next",
                    width: null,
                    isActive: count >= 3,
                    onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef OnManageCountFunction = void Function();

class InterestButton extends StatefulWidget {
  final OnManageCountFunction onIncreaseCount;
  final OnManageCountFunction onDecreaseCount;

  const InterestButton({
    super.key,
    required this.music,
    required this.onIncreaseCount,
    required this.onDecreaseCount,
  });

  final String music;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      if (_isSelected) {
        widget.onDecreaseCount();
      } else {
        widget.onIncreaseCount();
      }
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size14,
          horizontal: Sizes.size20,
        ),
        decoration: BoxDecoration(
          color: _isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
          border: Border.all(
            color:
                _isSelected ? Colors.transparent : Colors.grey.withOpacity(0.5),
            width: Sizes.size1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextBlack(
          text: widget.music,
          color: _isSelected ? Colors.white : Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
      ),
    );
  }
}
