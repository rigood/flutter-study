import 'package:go_router/go_router.dart';
import 'package:threads/screens/home_screen.dart';
import 'package:threads/screens/post_screen.dart';
import 'package:threads/screens/settings_screen.dart';
import 'package:threads/screens/privacy_screen.dart';
import 'package:threads/screens/search_screen.dart';
import 'package:threads/screens/activity_screen.dart';
import 'package:threads/screens/profile_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => HomeScreen(
        routeName: PostScreen.routeName,
      ),
      routes: [
        GoRoute(
          name: SettingsScreen.routeName,
          path: SettingsScreen.routeName,
          builder: (context, state) => HomeScreen(
            routeName: SettingsScreen.routeName,
          ),
          routes: [
            GoRoute(
              name: PrivacyScreen.routeName,
              path: PrivacyScreen.routeName,
              builder: (context, state) {
                return HomeScreen(
                  routeName: PrivacyScreen.routeName,
                );
              },
            )
          ],
        ),
        GoRoute(
          path:
              ":routeName(${SearchScreen.routeName}|${ActivityScreen.routeName}|${ProfileScreen.routeName})",
          builder: (context, state) {
            final routeName = state.params['routeName'];
            return HomeScreen(routeName: routeName!);
          },
        ),
      ],
    ),
  ],
);
