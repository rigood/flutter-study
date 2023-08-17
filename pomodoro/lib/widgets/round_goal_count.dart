import 'package:flutter/material.dart';

class RoundGoalCount extends StatelessWidget {
  final int round;
  final int goal;

  const RoundGoalCount({
    super.key,
    required this.round,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              children: [
                Text(
                  '$round/4',
                  style: TextStyle(
                    color: Colors.red.shade200,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  "ROUND",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          width: 100,
        ),
        Column(
          children: [
            Row(
              children: [
                Text(
                  '$goal/12',
                  style: TextStyle(
                    color: Colors.red.shade200,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  "GOAL",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
