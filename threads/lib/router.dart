import 'package:go_router/go_router.dart';
import 'package:threads/screens/home_screen.dart';
import 'package:threads/screens/privacy_screen.dart';
import 'package:threads/screens/settings_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(
        routeName: "",
      ),
      routes: [
        GoRoute(
          path: "settings",
          builder: (context, state) => HomeScreen(
            routeName: SettingsScreen.routeName,
          ),
          routes: [
            GoRoute(
              path: "privacy",
              builder: (context, state) {
                return HomeScreen(
                  routeName: PrivacyScreen.routeName,
                );
              },
            )
          ],
        ),
        GoRoute(
          path: ":routeName",
          builder: (context, state) {
            final routeName = state.params['routeName'];
            return HomeScreen(routeName: routeName!);
          },
        ),
      ],
    ),
  ],
);
