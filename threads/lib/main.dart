import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threads/repos/darkmode_config_repo.dart';
import 'package:threads/router.dart';
import 'package:threads/view_models/darkmode_config_vm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      routerConfig: router,
      title: "Threads",
      themeMode: ref.watch(darkmodeConfigProvider).darkmode
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
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
      ),
    );
  }
}
