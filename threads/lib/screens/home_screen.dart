import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threads/constants/sizes.dart';
import 'package:threads/widgets/nav_tab.dart';
import 'package:threads/screens/post_screen.dart';
import 'package:threads/screens/search_screen.dart';
import 'package:threads/screens/write_screen.dart';
import 'package:threads/screens/activity_screen.dart';
import 'package:threads/screens/profile_screen.dart';
import 'package:threads/screens/settings_screen.dart';
import 'package:threads/screens/privacy_screen.dart';

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
  late final int _selectedIndex = _routeNames.indexOf(widget.routeName);

  final List<String> _routeNames = [
    PostScreen.routeName,
    SearchScreen.routeName,
    PostScreen.routeName,
    ActivityScreen.routeName,
    ProfileScreen.routeName,
    SettingsScreen.routeName,
    PrivacyScreen.routeName
  ];

  final screens = [
    const PostScreen(),
    const SearchScreen(),
    const PostScreen(),
    const ActivityScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
    const PrivacyScreen()
  ];

  void _onNavTap(int index) {
    context.push("/${_routeNames[index]}");
  }

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
                onTap: () => _onNavTap(0),
              ),
              NavTab(
                icon: FontAwesomeIcons.magnifyingGlass,
                isSelected: _selectedIndex == 1,
                onTap: () => _onNavTap(1),
              ),
              NavTab(
                icon: FontAwesomeIcons.penToSquare,
                isSelected: _selectedIndex == 2,
                onTap: _onWriteTap,
              ),
              NavTab(
                icon: FontAwesomeIcons.heart,
                isSelected: _selectedIndex == 3,
                onTap: () => _onNavTap(3),
              ),
              NavTab(
                icon: FontAwesomeIcons.user,
                isSelected: _selectedIndex == 4 ||
                    _selectedIndex == 5 ||
                    _selectedIndex == 6,
                onTap: () => _onNavTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
