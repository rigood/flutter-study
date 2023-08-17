import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/timer_card.dart';

class TimerBox extends StatelessWidget {
  final String minutes;
  final String seconds;

  const TimerBox({super.key, required this.minutes, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TimerCard(minutes),
          const ColonDivider(),
          TimerCard(seconds),
        ],
      ),
    );
  }
}

class ColonDivider extends StatelessWidget {
  const ColonDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 10,
      ),
      child: Text(
        ":",
        style: TextStyle(
          fontSize: 40,
          color: Colors.red.shade100,
        ),
      ),
    );
  }
}
