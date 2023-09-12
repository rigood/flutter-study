import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/sizes.dart';
import 'package:threads/screens/post_screen.dart';
import 'package:threads/screens/privacy_screen.dart';
import 'package:threads/screens/profile_screen.dart';
import 'package:threads/screens/search_screen.dart';
import 'package:threads/screens/settings_screen.dart';
import 'package:threads/screens/write_screen.dart';
import 'package:threads/screens/activity_screen.dart';
import 'package:threads/widgets/nav_tab.dart';
import 'package:go_router/go_router.dart';

int _getSelectedIndex(String routeName) {
  if (routeName == SearchScreen.routeName) {
    return 1;
  } else if (routeName == ActivityScreen.routeName) {
    return 3;
  } else if (routeName == ProfileScreen.routeName) {
    return 4;
  } else if (routeName == SettingsScreen.routeName) {
    return 5;
  } else if (routeName == PrivacyScreen.routeName) {
    return 6;
  } else {
    return 0;
  }
}

class HomeScreen extends StatefulWidget {
  final String routeName;
  const HomeScreen({
    super.key,
    required this.routeName,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  void _onTap(String routeName) {
    context.push("/$routeName");
  }

  final screens = [
    PostScreen(),
    const SearchScreen(),
    PostScreen(),
    const ActivityScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
    const PrivacyScreen(),
  ];

  void _onWriteTap() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const WriteScreen(),
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.75),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = _getSelectedIndex(widget.routeName);

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size16,
            horizontal: Sizes.size24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                icon: FontAwesomeIcons.house,
                isSelected: _selectedIndex == 0,
                onTap: () => _onTap(PostScreen.routeName),
              ),
              NavTab(
                icon: FontAwesomeIcons.magnifyingGlass,
                isSelected: _selectedIndex == 1,
                onTap: () => _onTap(SearchScreen.routeName),
              ),
              NavTab(
                icon: FontAwesomeIcons.penToSquare,
                isSelected: _selectedIndex == 2,
                onTap: _onWriteTap,
              ),
              NavTab(
                icon: FontAwesomeIcons.heart,
                isSelected: _selectedIndex == 3,
                onTap: () => _onTap(ActivityScreen.routeName),
              ),
              NavTab(
                icon: FontAwesomeIcons.user,
                isSelected: _selectedIndex == 4 ||
                    _selectedIndex == 5 ||
                    _selectedIndex == 6,
                onTap: () => _onTap(ProfileScreen.routeName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Placeholder extends StatelessWidget {
  final String text;

  const Placeholder({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: Sizes.size36,
        ),
      ),
    );
  }
}
