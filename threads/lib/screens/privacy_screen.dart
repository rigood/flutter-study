import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/gaps.dart';
import 'package:go_router/go_router.dart';

class PrivacyScreen extends StatefulWidget {
  static String routeName = "privacy";

  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _privacyProfile = false;

  void _onPrivacyProfileChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _privacyProfile = newValue;
    });
  }

  void _onBackTap() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: _onBackTap,
          child: const Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  size: 16,
                ),
                Gaps.h5,
                Text(
                  "Back",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        title: const Text("Privacy"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            contentPadding: const EdgeInsets.only(
              left: 10,
            ),
            title: const Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.lock,
                  color: Colors.black,
                  size: 20,
                ),
                Gaps.h16,
                Text("Privacy profile"),
              ],
            ),
            value: _privacyProfile,
            onChanged: _onPrivacyProfileChanged,
          ),
          const SettingsListTile(
            icon: FontAwesomeIcons.font,
            text: "Mentions",
            trailingType: TrailingType.chevronRightIconWithText,
          ),
          const SettingsListTile(
            icon: FontAwesomeIcons.bellSlash,
            text: "Muted",
            trailingType: TrailingType.chevronRightIcon,
          ),
          const SettingsListTile(
            icon: FontAwesomeIcons.eyeSlash,
            text: "Hidden Words",
            trailingType: TrailingType.chevronRightIcon,
          ),
          const SettingsListTile(
            icon: FontAwesomeIcons.userGroup,
            text: "Profiles you follow",
            trailingType: TrailingType.chevronRightIcon,
          ),
          const Divider(
            color: Colors.grey,
          ),
          const ListTile(
            contentPadding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            minVerticalPadding: 10,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Other privacy settings",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gaps.v10,
                      Text(
                        "Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.upRightFromSquare,
                  size: 16,
                ),
              ],
            ),
          ),
          const SettingsListTile(
            icon: FontAwesomeIcons.circleXmark,
            text: "Blocked profiles",
            trailingType: TrailingType.shareIcon,
          ),
          const SettingsListTile(
            icon: FontAwesomeIcons.heartCrack,
            text: "Hidden likes",
            trailingType: TrailingType.shareIcon,
          ),
        ],
      ),
    );
  }
}

enum TrailingType {
  chevronRightIcon,
  chevronRightIconWithText,
  shareIcon,
}

class SettingsListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final TrailingType trailingType;

  const SettingsListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.trailingType,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      titleAlignment: ListTileTitleAlignment.center,
      iconColor: Colors.black,
      leading: FaIcon(
        icon,
        size: 20,
      ),
      horizontalTitleGap: -5,
      title: Text(text),
      trailing: getTrailingWidget(trailingType),
    );
  }
}

Widget getTrailingWidget(trailingType) {
  switch (trailingType) {
    case TrailingType.chevronRightIcon:
      return const FaIcon(
        FontAwesomeIcons.chevronRight,
        size: 16,
        color: Colors.grey,
      );
    case TrailingType.chevronRightIconWithText:
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Everyone",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Gaps.h10,
          FaIcon(
            FontAwesomeIcons.chevronRight,
            size: 16,
            color: Colors.grey,
          ),
        ],
      );
    case TrailingType.shareIcon:
      return const FaIcon(
        FontAwesomeIcons.upRightFromSquare,
        size: 16,
        color: Colors.grey,
      );

    default:
      return const FaIcon(FontAwesomeIcons.accessibleIcon);
  }
}
