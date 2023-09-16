import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/screens/create_account_screen.dart';
import 'package:threads/utils.dart';
import 'package:threads/view_models/login_vm.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String routeURL = "/login";

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmit() {
    _hideKeyboard();

    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
    }

    ref.read(loginProvider.notifier).login(
          formData["email"]!,
          formData["password"]!,
          context,
        );
  }

  String? _validatePassword(password) {
    if (password.isEmpty) {
      return "비밀번호를 입력해주세요";
    }

    if (password.length < 6) {
      return "비밀번호를 4자 이상 입력해주세요";
    }
    return null;
  }

  String? _validateEmail(email) {
    if (email.isEmpty) return null;

    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return !regExp.hasMatch(email) ? "올바른 이메일 주소를 입력해주세요." : null;
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hideKeyboard,
      child: Scaffold(
        backgroundColor: const Color(0xffF3F8FE),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Column(
                  children: [
                    const Text(
                      "English(US)",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Gaps.v60,
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color:
                            isDarkMode(context) ? Colors.white : Colors.black,
                      ),
                      child: Center(
                        child: Image(
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                          image: AssetImage(isDarkMode(context)
                              ? "assets/images/logo.png"
                              : "assets/images/logo_dark.png"),
                        ),
                      ),
                    ),
                    Gaps.v80,
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: _validateEmail,
                            onSaved: (newValue) {
                              if (newValue != null) {
                                formData['email'] = newValue;
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Mobile number or email",
                              hintStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Gaps.v10,
                          TextFormField(
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            validator: _validatePassword,
                            onSaved: (newValue) {
                              if (newValue != null) {
                                formData['password'] = newValue;
                              }
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Gaps.v10,
                          GestureDetector(
                            onTap: _onSubmit,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xff0C64E0),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                ref.watch(loginProvider).isLoading
                                    ? "Processing"
                                    : "Log in",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v20,
                    const Text(
                      "Forgot password?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => context.go(CreateAccountScreen.routeURL),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: const Text(
                            "Create new account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Gaps.v20,
                      const Text("Meta"),
                    ],
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
