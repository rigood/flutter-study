import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:threads/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/repos/darkmode_config_repo.dart';
import 'package:threads/view_models/darkmode_config_vm.dart';
import 'package:threads/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final preferences = await SharedPreferences.getInstance();
  final repository = DarkmodeConfigRepository(preferences);

  runApp(
    ProviderScope(
      overrides: [
        darkmodeConfigProvider
            .overrideWith(() => DarkmodeConfigViewModel(repository))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: "Threads",
      themeMode: ref.watch(darkmodeConfigProvider).isDarkmode
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.white,
        dividerColor: Colors.grey.shade100,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelMedium: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
          labelSmall: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            letterSpacing: 0,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.black,
        ),
        dividerColor: Colors.grey.shade900,
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          labelMedium: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
          labelSmall: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
