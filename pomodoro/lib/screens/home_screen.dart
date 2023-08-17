import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pomodoro/widgets/app_title.dart';
import 'package:pomodoro/widgets/time_select_list.dart';
import 'package:pomodoro/widgets/timer_box.dart';
import 'package:pomodoro/widgets/play_pause_button.dart';
import 'package:pomodoro/widgets/round_goal_count.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer workingTimer;
  late Timer restTimer;

  static const defaultWorkingTime = 25 * 60;
  static const defaultRestTime = 5 * 60;

  int workingTime = defaultWorkingTime;
  int restTime = defaultRestTime;

  int selectedMinute = 25;

  bool isRunning = false;

  static const working = 'working';
  static const rest = 'rest';
  String current = working;

  int round = 0;
  int goal = 0;

  void startTimer() {
    if (current == working) {
      workingTimer = Timer.periodic(
        const Duration(seconds: 1),
        onWorkingTick,
      );
    } else {
      restTimer = Timer.periodic(
        const Duration(seconds: 1),
        onRestTick,
      );
    }

    setState(() {
      isRunning = true;
    });
  }

  void pauseTimer() {
    if (current == working) {
      workingTimer.cancel();
    } else {
      restTimer.cancel();
    }

    setState(() {
      isRunning = false;
    });
  }

  void onWorkingTick(Timer timer) {
    if (workingTime == 0) {
      workingTimer.cancel();
      restTimer = Timer.periodic(
        const Duration(seconds: 1),
        onRestTick,
      );

      setState(() {
        round = round + 1;
        workingTime = selectedMinute * 60;
        current = rest;
      });
    } else {
      setState(() {
        workingTime = workingTime - 1;
      });
    }

    if (round == 4) {
      round = 0;
      goal = goal + 1;
    }
  }

  void onRestTick(Timer timer) {
    if (restTime == 0) {
      restTimer.cancel();
      workingTimer = Timer.periodic(
        const Duration(seconds: 1),
        onWorkingTick,
      );

      setState(() {
        restTime = defaultRestTime;
        current = working;
      });
    } else {
      setState(() {
        restTime = restTime - 1;
      });
    }
  }

  void onTimeSelect(int minute) {
    setState(() {
      workingTime = minute * 60;
      selectedMinute = minute;
    });
  }

  List<String> format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration
        .toString()
        .split('.')
        .first
        .substring(2)
        .toString()
        .split(':');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppTitle(),
          Status(
            status: current,
          ),
          TimerBox(
            minutes: format(current == working ? workingTime : restTime).first,
            seconds: format(current == working ? workingTime : restTime).last,
          ),
          TimeSelectList(
              selectedMinute: selectedMinute, onTimeSelect: onTimeSelect),
          PlayPauseButton(
              isRunning: isRunning,
              onPressed: isRunning ? pauseTimer : startTimer),
          RoundGoalCount(
            round: round,
            goal: goal,
          ),
        ],
      ),
    );
  }
}

class Status extends StatelessWidget {
  final String status;
  static const working = "working";

  const Status({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        status == working ? "⌛ Core Time ⌛" : "💤 Take a rest! 💤",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
