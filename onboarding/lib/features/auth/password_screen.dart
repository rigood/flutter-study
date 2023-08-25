import 'package:flutter/material.dart';
import 'package:onboarding/constants/sizes.dart';
import 'package:onboarding/constants/gaps.dart';
import 'package:onboarding/features/onboarding/interests_screen_vertical.dart';
import 'package:onboarding/widgets/app_logo.dart';
import 'package:onboarding/widgets/page_title.dart';
import 'package:onboarding/widgets/page_subtitle.dart';
import 'package:onboarding/features/auth/widgets/circle_icon.dart';
import 'package:onboarding/widgets/bottom_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  String _password = "";
  bool _obscureText = true;

  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length >= 8;
  }

  void _onNextTap() {
    if (!_isPasswordValid()) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InterestsScreenVertial()),
    );
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PageTitle(text: "You'll need a password"),
                    Gaps.v20,
                    const PageSubtitle(
                        text: "Make sure it's 8 characters or more."),
                    Gaps.v20,
                    TextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.number,
                      obscureText: _obscureText,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: _password.isEmpty ? "Password" : null,
                        labelText: _password.isNotEmpty ? "Password" : null,
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        suffix: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: _toggleObscureText,
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            Gaps.h10,
                            if (_isPasswordValid()) const CircleIcon(),
                          ],
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: BottomButton(
                    text: "Next",
                    isActive: _isPasswordValid(),
                    onTap: _onNextTap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
