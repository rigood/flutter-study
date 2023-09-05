import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/screens/privacy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _onBackTap() {
    Navigator.of(context).pop();
  }

  void _onPrivacyTap() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PrivacyScreen()),
    );
  }

  void _onLogoutTap() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure to log out?"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("No"),
          ),
        ],
      ),
    );
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
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator.adaptive(),
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
      iconColor: Colors.black,
      leading: FaIcon(
        icon,
        size: 20,
      ),
      horizontalTitleGap: -5,
      title: Text(text),
    );
  }
}
