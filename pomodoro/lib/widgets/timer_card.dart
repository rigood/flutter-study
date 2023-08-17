import 'package:flutter/material.dart';

class TimerCard extends StatelessWidget {
  final String time;

  const TimerCard(this.time, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 18,
        ),
        child: Text(
          time,
          style: TextStyle(
            color: Theme.of(context).colorScheme.background,
            fontSize: 75,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
