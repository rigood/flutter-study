import 'package:flutter/material.dart';
import 'package:threads/screens/home_screen.dart';
import 'package:threads/screens/video_recording_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Threads",
      home: VideoRecordingScreen(),
    );
  }
}
