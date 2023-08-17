import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/time_select.dart';

typedef TimeSelectCB = void Function(int minute);

class TimeSelectList extends StatelessWidget {
  final int selectedMinute;
  final TimeSelectCB onTimeSelect;

  const TimeSelectList(
      {super.key, required this.selectedMinute, required this.onTimeSelect});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Center(
          child: Row(children: [
            const Space(),
            TimeSelect(
              minute: 15,
              isSelected: selectedMinute == 15,
              onTimeSelect: onTimeSelect,
            ),
            const Space(),
            TimeSelect(
              minute: 20,
              isSelected: selectedMinute == 20,
              onTimeSelect: onTimeSelect,
            ),
            const Space(),
            TimeSelect(
              minute: 25,
              isSelected: selectedMinute == 25,
              onTimeSelect: onTimeSelect,
            ),
            const Space(),
            TimeSelect(
              minute: 30,
              isSelected: selectedMinute == 30,
              onTimeSelect: onTimeSelect,
            ),
            const Space(),
            TimeSelect(
              minute: 35,
              isSelected: selectedMinute == 35,
              onTimeSelect: onTimeSelect,
            ),
            const Space(),
          ]),
        ));
  }
}

class Space extends StatelessWidget {
  const Space({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 30,
    );
  }
}
