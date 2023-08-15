import 'package:flutter/material.dart';
import 'package:challenge/widgets/Timeline.dart';

class TodoCard extends StatelessWidget {
  final Color cardBgColor;
  final String todoText;
  final int startHour, startMinute, endHour, endMinute;
  final String personName1;
  final String personName2;
  final String personName3;

  const TodoCard({
    super.key,
    required this.cardBgColor,
    required this.todoText,
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
    required this.personName1,
    required this.personName2,
    required this.personName3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          15,
          30,
          15,
          15,
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            flex: 1,
            child: Timeline(startHour, startMinute, endHour, endMinute),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 9,
            child: Column(
              children: [
                Text(
                  todoText,
                  style: const TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w500,
                    height: 0.9,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Person(personName1),
                    Person(personName2),
                    Person(personName3),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class Person extends StatelessWidget {
  final String name;

  const Person(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 13,
          color: (name == "ME") ? Colors.black : Colors.black38,
          fontWeight: (name == "ME") ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
    );
  }
}
