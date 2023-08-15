import 'package:flutter/material.dart';

class Timeline extends StatelessWidget {
  final int startHour, startMinute, endHour, endMinute;

  const Timeline(this.startHour, this.startMinute, this.endHour, this.endMinute,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          startHour.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          startMinute.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 20,
          child: VerticalDivider(
            thickness: 1,
            color: Colors.black38,
          ),
        ),
        Text(
          endHour.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          endMinute.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
