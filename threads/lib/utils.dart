import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

bool isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

void showFirebaseErrorSnack(
  BuildContext context,
  Object? error,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      content: Text(
        (error as FirebaseException).message ?? "에러가 발생했습니다.",
      ),
    ),
  );
}

String getPostReadingTime(int postTextLength) {
  final int time = (postTextLength / 100).floor();
  return "${time}m";
}
