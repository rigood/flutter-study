import 'package:flutter/material.dart';
import 'package:onboarding/constants/sizes.dart';
import 'package:onboarding/constants/gaps.dart';
import 'package:onboarding/features/auth/confirmation_code_screen.dart';
import 'package:onboarding/widgets/app_logo.dart';
import 'package:onboarding/widgets/bottom_button.dart';
import 'package:onboarding/widgets/page_title.dart';
import 'package:onboarding/features/auth/widgets/circle_icon.dart';

class CreateAccountConfirmScreen extends StatefulWidget {
  final String username, email, birthday;

  const CreateAccountConfirmScreen({
    super.key,
    required this.username,
    required this.email,
    required this.birthday,
  });

  @override
  State<CreateAccountConfirmScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountConfirmScreen> {
  String _username = "";
  String _email = "";
  String _birthday = "";

  DateTime initialDate = DateTime.now();
  bool _isBirthdayTapped = false;

  bool _isFormValid = true;
  Map<String, String> formData = {};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.username;
    _emailController.text = widget.email;
    _birthdayController.text = widget.birthday;

    _username = widget.username;
    _email = widget.email;
    _birthday = widget.birthday;

    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _birthdayController.addListener(() {
      setState(() {
        _birthday = _birthdayController.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  bool _isEmailValid() {
    if (_email.isEmpty) return false;

    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return regExp.hasMatch(_email);
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  void _onFormChange() {
    var emailValid = _isEmailValid();
    setState(() {
      if (_username.isNotEmpty && emailValid == true && _birthday.isNotEmpty) {
        _isFormValid = true;
      } else {
        _isFormValid = false;
      }
    });
  }

  void _onTextFormFieldTap() {
    if (_isBirthdayTapped) {
      setState(() {
        _isBirthdayTapped = false;
      });
    }
  }

  void _onBirthdayTap() {
    FocusScope.of(context).unfocus();

    setState(() {
      _isBirthdayTapped = !_isBirthdayTapped;
    });
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();

    if (_isBirthdayTapped) {
      setState(() {
        _isBirthdayTapped = false;
      });
    }
  }

  void _onSignUpTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
    }

    if (_isFormValid) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmationCodeScreen(
            email: _email,
          ),
        ),
      );
    }
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
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  onChanged: _onFormChange,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gaps.v20,
                      const PageTitle(
                        text: "Create your account",
                        fontSize: 24,
                      ),
                      Gaps.v20,
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _usernameController,
                        onTap: _onTextFormFieldTap,
                        onSaved: (newValue) {
                          if (newValue != null) {
                            formData['username'] = newValue;
                          }
                        },
                        validator: (val) {
                          return null;
                        },
                        cursorColor: Theme.of(context).colorScheme.primary,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        decoration: InputDecoration(
                          hintText: _username.isEmpty ? "Name" : null,
                          labelText: _username.isNotEmpty ? "Name" : null,
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          suffix:
                              _username.isNotEmpty ? const CircleIcon() : null,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Gaps.v20,
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        onTap: _onTextFormFieldTap,
                        onSaved: (value) {
                          if (value != null) {
                            formData['email'] = value;
                          }
                        },
                        validator: (val) {
                          return null;
                        },
                        cursorColor: Theme.of(context).colorScheme.primary,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        decoration: InputDecoration(
                          hintText: _email.isEmpty ? "Email" : null,
                          labelText: _email.isNotEmpty ? "Email" : null,
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          suffix: _isEmailValid() ? const CircleIcon() : null,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Gaps.v20,
                      GestureDetector(
                        onTap: _onBirthdayTap,
                        child: AbsorbPointer(
                          child: TextFormField(
                            readOnly: true,
                            controller: _birthdayController,
                            onSaved: (value) {
                              if (value != null) {
                                formData['birthday'] = value;
                              }
                            },
                            validator: (val) {
                              return null;
                            },
                            cursorColor: Theme.of(context).colorScheme.primary,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  _birthday.isEmpty ? "Date of birth" : null,
                              labelText:
                                  _birthday.isNotEmpty ? "Date of birth" : null,
                              labelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              suffix: _birthday.isNotEmpty
                                  ? const CircleIcon()
                                  : null,
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.25,
                  bottom: 0,
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.3,
                      ),
                      children: [
                        const TextSpan(
                            text: "By signing up, you agree to our "),
                        TextSpan(
                          text: "Terms of Service",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const TextSpan(text: ", including "),
                        TextSpan(
                          text: "Cookie Use",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const TextSpan(
                            text:
                                ". Twitter may use your contact information, including your email address and phone number for purposes outlined n our Privacy Policy, like keeping your account secure and personalizing our services, including ads. "),
                        TextSpan(
                          text: "Learn more",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const TextSpan(
                            text:
                                ". Others will be able to find you by email or phone number, when provided, unless you choose to otherwise "),
                        TextSpan(
                          text: "here",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const TextSpan(text: "."),
                      ],
                    ),
                  ),
                )
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
              text: "Sign up",
              isActive: _isFormValid,
              onTap: _onSignUpTap,
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
