import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/utils.dart';
import 'package:threads/repos/auth_repo.dart';
import 'package:threads/screens/privacy_screen.dart';
import 'package:threads/view_models/darkmode_config_vm.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  static String routeName = "settings";

  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends ConsumerState<SettingsScreen> {
  void _onBackTap() {
    context.pop();
  }

  void _onPrivacyTap() {
    context.pushNamed(PrivacyScreen.routeName);
  }

  void _onLogoutTap() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure to log out?"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              ref.read(authRepo).signOut();
            },
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          const SettingsListTile(
            icon: FontAwesomeIcons.userPlus,
            text: "Follow and invite friends",
          ),
          const SettingsListTile(
            icon: FontAwesomeIcons.bell,
            text: "Notifications",
          ),
          GestureDetector(
            onTap: _onPrivacyTap,
            child: const SettingsListTile(
              icon: FontAwesomeIcons.lock,
              text: "Privacy",
            ),
          ),
          const SettingsListTile(
            icon: FontAwesomeIcons.circleUser,
            text: "Account",
          ),
          const SettingsListTile(
            icon: FontAwesomeIcons.hireAHelper,
            text: "Help",
          ),
          const SettingsListTile(
            icon: FontAwesomeIcons.circleInfo,
            text: "About",
          ),
          const Divider(
            color: Colors.grey,
          ),
          SwitchListTile.adaptive(
            title: const Text("Dark mode"),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            value: ref.watch(darkmodeConfigProvider).isDarkmode,
            onChanged: (value) =>
                ref.read(darkmodeConfigProvider.notifier).setDarkmode(value),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _onLogoutTap,
                  child: const Text(
                    "Log out",
                    style: TextStyle(
                      color: Color(0xff1E8EFF),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const SettingsListTile({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 10,
      ),
      titleAlignment: ListTileTitleAlignment.center,
      iconColor: isDarkMode(context) ? Colors.white : Colors.black,
      leading: FaIcon(
        icon,
        size: 20,
      ),
      horizontalTitleGap: -5,
      title: Text(text),
    );
  }
}
