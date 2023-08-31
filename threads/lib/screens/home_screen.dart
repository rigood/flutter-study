import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/sizes.dart';
import 'package:threads/screens/post_screen.dart';
import 'package:threads/screens/write_screen.dart';
import 'package:threads/widgets/nav_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [
    PostScreen(),
    const Placeholder(text: "Search"),
    PostScreen(),
    const Placeholder(text: "Notifications"),
    const Placeholder(text: "Profile"),
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
                    onTap: () => _onTap(0),
                  ),
                  NavTab(
                    icon: FontAwesomeIcons.magnifyingGlass,
                    isSelected: _selectedIndex == 1,
                    onTap: () => _onTap(1),
                  ),
                  NavTab(
                    icon: FontAwesomeIcons.penToSquare,
                    isSelected: _selectedIndex == 2,
                    onTap: _onWriteTap,
                  ),
                  NavTab(
                    icon: FontAwesomeIcons.heart,
                    isSelected: _selectedIndex == 3,
                    onTap: () => _onTap(3),
                  ),
                  NavTab(
                    icon: FontAwesomeIcons.user,
                    isSelected: _selectedIndex == 4,
                    onTap: () => _onTap(4),
                  ),
                ],
              ),
            )));
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
