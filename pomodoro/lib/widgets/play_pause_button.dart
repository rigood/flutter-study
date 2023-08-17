import 'package:flutter/material.dart';

typedef OnPressedCallback = void Function();

class PlayPauseButton extends StatelessWidget {
  final bool isRunning;
  final OnPressedCallback onPressed;

  const PlayPauseButton(
      {super.key, required this.isRunning, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          iconSize: 100,
          icon: Icon(
            isRunning ? Icons.pause_circle_outlined : Icons.play_circle_outline,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
