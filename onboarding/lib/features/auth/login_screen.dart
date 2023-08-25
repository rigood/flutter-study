import 'package:flutter/material.dart';
import 'package:onboarding/constants/sizes.dart';
import 'package:onboarding/constants/gaps.dart';
import 'package:onboarding/features/auth/create_account_screen.dart';
import 'package:onboarding/widgets/app_logo.dart';
import 'package:onboarding/widgets/page_title.dart';
import 'package:onboarding/features/auth/widgets/auth_button.dart';
import 'package:onboarding/features/auth/widgets/custom_divider.dart';
import 'package:onboarding/widgets/text_black.dart';
import 'package:onboarding/widgets/text_primary.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _onCreateAccountTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateAccountScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: AppLogo(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
            horizontal: Sizes.size24,
          ),
          child: Column(
            children: [
              Gaps.v80,
              const PageTitle(
                  text: "See what's happening in the world right now."),
              Gaps.v80,
              AuthButton(
                isInverted: false,
                text: "Continue with Google",
                logo: Image.asset('assets/images/google.png'),
              ),
              Gaps.v12,
              AuthButton(
                isInverted: false,
                text: "Continue with Apple",
                logo: Image.asset('assets/images/apple.png'),
              ),
              Gaps.v12,
              const CustomDivider(
                text: "or",
              ),
              Gaps.v8,
              AuthButton(
                isInverted: true,
                text: "Create account",
                onTap: () => _onCreateAccountTap(context),
              ),
              Gaps.v24,
              const FractionallySizedBox(
                widthFactor: 1,
                child: Wrap(
                  children: [
                    TextBlack(text: "By signing up, you agree to our "),
                    TextPrimary(
                      text: "Terms",
                    ),
                    Text(", "),
                    TextPrimary(
                      text: "Privacy Policy",
                    ),
                    Text(", and "),
                    TextPrimary(
                      text: "Cookie Use",
                    ),
                    Text("."),
                  ],
                ),
              ),
              Gaps.v24,
              const FractionallySizedBox(
                widthFactor: 1,
                child: Wrap(
                  children: [
                    TextBlack(
                      text: "Have an account already? ",
                      fontSize: 12,
                    ),
                    TextPrimary(
                      text: "Log In",
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
