import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onboarding/constants/sizes.dart';
import 'package:onboarding/constants/gaps.dart';
import 'package:onboarding/features/auth/customize_experience_screen.dart';
import 'package:onboarding/widgets/app_logo.dart';
import 'package:onboarding/widgets/page_title.dart';
import 'package:onboarding/widgets/text_black.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String _username = "";
  String _email = "";
  String _birthday = "";

  DateTime initialDate = DateTime.now();
  bool _isBirthdayTapped = false;

  bool _isFormValid = false;
  Map<String, String> formData = {};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  @override
  void initState() {
    super.initState();
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

  void _onNextTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
    }

    if (_isFormValid) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CustomizeExperienceScreen(
            username: _username,
            email: _email,
            birthday: _birthday,
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
            automaticallyImplyLeading: false,
            title: const Stack(alignment: Alignment.center, children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextBlack(
                  text: "Cancel",
                ),
              ),
              Center(
                child: AppLogo(),
              ),
            ]),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size10,
                horizontal: Sizes.size24,
              ),
              child: Form(
                key: _formKey,
                onChanged: _onFormChange,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.v20,
                        const PageTitle(
                          text: "Create your account",
                          fontSize: 24,
                        ),
                        Gaps.v20,
                        TextFormField(
                          autofocus: true,
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
                            suffix: _username.isNotEmpty
                                ? const CircleIcon()
                                : null,
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
                              cursorColor:
                                  Theme.of(context).colorScheme.primary,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    _birthday.isEmpty ? "Date of birth" : null,
                                labelText: _birthday.isNotEmpty
                                    ? "Date of birth"
                                    : null,
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
                        Gaps.v10,
                        Row(
                          children: [
                            if (_isBirthdayTapped)
                              const Expanded(
                                  child: TextBlack(
                                text:
                                    "This will not be shown publicly. Confirm your own age, even if this account is for a business, a pet, or something else.",
                                fontSize: 14,
                              ))
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _onNextTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size12,
                            horizontal: Sizes.size24,
                          ),
                          decoration: BoxDecoration(
                            color: _isFormValid ? Colors.black : Colors.grey,
                            borderRadius: BorderRadius.circular(
                              Sizes.size24,
                            ),
                          ),
                          child: const Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: _isBirthdayTapped
              ? BottomAppBar(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    )),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: _setTextFieldDate,
                    ),
                  ),
                )
              : null),
    );
  }
}

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      FontAwesomeIcons.solidCircleCheck,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
