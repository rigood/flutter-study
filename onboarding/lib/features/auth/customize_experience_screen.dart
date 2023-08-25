import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:onboarding/constants/sizes.dart';
import 'package:onboarding/constants/gaps.dart';
import 'package:onboarding/features/auth/create_account_confirm_screen.dart';
import 'package:onboarding/widgets/app_logo.dart';
import 'package:onboarding/widgets/bottom_button.dart';
import 'package:onboarding/widgets/page_title.dart';
import 'package:onboarding/widgets/text_black.dart';

class CustomizeExperienceScreen extends StatefulWidget {
  final String username, email, birthday;

  const CustomizeExperienceScreen(
      {super.key,
      required this.username,
      required this.email,
      required this.birthday});

  @override
  State<CustomizeExperienceScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeExperienceScreen> {
  bool _isChecked = false;

  void _onSwitchChange(value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  void _onNextTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateAccountConfirmScreen(
          username: widget.username,
          email: widget.email,
          birthday: widget.birthday,
        ),
      ),
    );
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
            horizontal: Sizes.size24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              const PageTitle(
                text: "Customize your experience",
              ),
              Gaps.v20,
              const TextBlack(
                text: "Track where you see Twitter content across the web",
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
              Gaps.v20,
              Row(
                children: [
                  const Expanded(
                    flex: 4,
                    child: TextBlack(
                      text:
                          "Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, or phone number.",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.h10,
                  Expanded(
                    flex: 1,
                    child: CupertinoSwitch(
                      value: _isChecked,
                      onChanged: (value) => _onSwitchChange(value),
                      activeColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              Gaps.v20,
              Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                  children: [
                    const TextSpan(text: "By signing up, you agree to our "),
                    TextSpan(
                      text: "Terms",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const TextSpan(text: ", "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const TextSpan(text: ", and "),
                    TextSpan(
                      text: "Cookie Use",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const TextSpan(text: ". "),
                    const TextSpan(
                        text:
                            "Twitter may use your contact information, including your email address and phone number for purposes outlined n our Privacy Policy. "),
                    TextSpan(
                      text: "Learn more",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size20,
            horizontal: Sizes.size40,
          ),
          child: BottomButton(
            text: "Next",
            isActive: _isChecked,
            onTap: _onNextTap,
          ),
        ),
      ),
    );
  }
}
