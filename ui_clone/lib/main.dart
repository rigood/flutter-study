import 'package:challenge/widgets/Calendar.dart';
import 'package:flutter/material.dart';
import 'package:challenge/widgets/Header.dart';
import 'package:challenge/widgets/TodoCard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              50,
              20,
              10,
            ),
            child: Column(
              children: [
                Header(),
                SizedBox(
                  height: 30,
                ),
                Calendar(),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    TodoCard(
                      cardBgColor: Color(0xfffdf771),
                      todoText: "DESIGN MEETING",
                      startHour: 11,
                      startMinute: 30,
                      endHour: 12,
                      endMinute: 20,
                      personName1: "ALEX",
                      personName2: "HELENA",
                      personName3: "NANA",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TodoCard(
                      cardBgColor: Color(0xff956DC8),
                      todoText: "DAILY PROJECT",
                      startHour: 12,
                      startMinute: 35,
                      endHour: 14,
                      endMinute: 10,
                      personName1: "ME",
                      personName2: "RICHARD",
                      personName3: "CIRY",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TodoCard(
                      cardBgColor: Color(0xffC6ED67),
                      todoText: "WEEKLY PLANNING",
                      startHour: 15,
                      startMinute: 00,
                      endHour: 16,
                      endMinute: 30,
                      personName1: "DEN",
                      personName2: "NANA",
                      personName3: "MARK",
                    ),
                  ],
                ),
              ],
            )),
      ),
    ));
  }
}
