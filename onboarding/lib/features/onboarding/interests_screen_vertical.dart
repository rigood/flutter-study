import 'package:flutter/material.dart';
import 'package:onboarding/constants/sizes.dart';
import 'package:onboarding/constants/gaps.dart';
import 'package:onboarding/features/onboarding/interests_screen_horizontal.dart';
import 'package:onboarding/widgets/app_logo.dart';
import 'package:onboarding/widgets/page_title.dart';
import 'package:onboarding/widgets/page_subtitle.dart';
import 'package:onboarding/widgets/text_black.dart';
import 'package:onboarding/widgets/bottom_button.dart';

const interests = [
  "Fashion & beauty",
  "Outdoors",
  "Arts & culture",
  "Animation & comics",
  "Business & finance",
  "Food",
  "Travel",
  "Entertainment",
  "Music",
  "Gaming",
];

class InterestsScreenVertial extends StatefulWidget {
  const InterestsScreenVertial({super.key});

  @override
  State<InterestsScreenVertial> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreenVertial> {
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

  void _onNextTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => const InterestsScreenHorizontal()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: AppLogo(),
        ),
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
                          "Select at least 3 interests to personalize your Twitter experience. They will be visible on your profile."),
                  Gaps.v16,
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
                horizontal: Sizes.size5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (var interest in interests)
                        InterestButton(
                          interest: interest,
                          onIncreaseCount: onIncreaseCount,
                          onDecreaseCount: onDecreaseCount,
                        )
                    ],
                  )
                ],
              ),
            )
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
                Text(count >= 3 ? "Great work 🎉" : "$count of 3 selected"),
                BottomButton(
                    text: "Next",
                    width: null,
                    isActive: count >= 3,
                    onTap: _onNextTap),
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
    required this.interest,
    required this.onIncreaseCount,
    required this.onDecreaseCount,
  });

  final String interest;

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
        width: 160,
        height: 80,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
          horizontal: Sizes.size10,
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
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: TextBlack(
                    text: widget.interest,
                    color: _isSelected ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
