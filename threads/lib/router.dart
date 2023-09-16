import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:threads/repos/auth_repo.dart';
import 'package:threads/screens/home_screen.dart';
import 'package:threads/screens/login_screen.dart';
import 'package:threads/screens/post_screen.dart';
import 'package:threads/screens/settings_screen.dart';
import 'package:threads/screens/privacy_screen.dart';
import 'package:threads/screens/search_screen.dart';
import 'package:threads/screens/activity_screen.dart';
import 'package:threads/screens/profile_screen.dart';
import 'package:threads/screens/create_account_screen.dart';

final routerProvider = Provider(
  (ref) {
    ref.watch(authState);
    return GoRouter(
      initialLocation: "/",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.subloc != CreateAccountScreen.routeURL &&
              state.subloc != LoginScreen.routeURL) {
            return CreateAccountScreen.routeURL;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          path: CreateAccountScreen.routeURL,
          builder: (context, state) => const CreateAccountScreen(),
        ),
        GoRoute(
          path: LoginScreen.routeURL,
          builder: (context, state) => const LoginScreen(),
        ),
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
  },
);
