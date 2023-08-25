import 'package:flutter/material.dart';
import 'package:onboarding/constants/sizes.dart';
import 'package:onboarding/constants/gaps.dart';
import 'package:onboarding/features/auth/password_screen.dart';
import 'package:onboarding/widgets/app_logo.dart';
import 'package:onboarding/widgets/page_subtitle.dart';
import 'package:onboarding/widgets/page_title.dart';
import 'package:onboarding/widgets/bottom_button.dart';
import 'package:onboarding/features/auth/widgets/circle_icon.dart';

class ConfirmationCodeScreen extends StatefulWidget {
  const ConfirmationCodeScreen({super.key});

  @override
  State<ConfirmationCodeScreen> createState() => _ConfirmationCodeScreenState();
}

class _ConfirmationCodeScreenState extends State<ConfirmationCodeScreen> {
  bool _isValid = false;

  void _onComplete() {
    setState(() {
      _isValid = true;
    });
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onNextTap() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
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
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v20,
                  const PageTitle(
                    text: "We sent you a code",
                  ),
                  Gaps.v20,
                  const PageSubtitle(text: "Enter it below to verify"),
                  const Text(
                    "jhon.mobbin@gmail.com",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  Gaps.v20,
                  Row(
                    children: [
                      Password(
                        focus: FocusScope.of(context),
                      ),
                      Gaps.h10,
                      Password(
                        focus: FocusScope.of(context),
                      ),
                      Gaps.h10,
                      Password(
                        focus: FocusScope.of(context),
                      ),
                      Gaps.h10,
                      Password(
                        focus: FocusScope.of(context),
                      ),
                      Gaps.h10,
                      Password(
                        focus: FocusScope.of(context),
                      ),
                      Gaps.h10,
                      Password(
                        focus: FocusScope.of(context),
                        isLastFocus: true,
                        onComplete: _onComplete,
                      ),
                    ],
                  ),
                  if (_isValid)
                    const Padding(
                      padding: EdgeInsets.only(
                        top: Sizes.size20,
                      ),
                      child: Center(child: CircleIcon()),
                    )
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Didn't receive email?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    Gaps.v10,
                    BottomButton(
                      text: "Next",
                      isActive: _isValid,
                      onTap: _onNextTap,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

typedef OnCompleteFunction = void Function();

class Password extends StatelessWidget {
  final FocusScopeNode focus;
  final bool isLastFocus;
  final OnCompleteFunction? onComplete;

  const Password({
    super.key,
    required this.focus,
    this.isLastFocus = false,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: TextField(
        autofocus: true,
        keyboardType: TextInputType.number,
        onChanged: (newValue) {
          if (newValue.length == 1) {
            focus.unfocus();
            if (!isLastFocus) {
              focus.nextFocus();
            } else {
              onComplete!();
            }
          }
        },
        textInputAction: TextInputAction.next,
        cursorColor: Theme.of(context).colorScheme.primary,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w900,
        ),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
