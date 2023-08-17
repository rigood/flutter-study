import 'package:flutter/material.dart';

typedef TimeSelectCB = void Function(int minute);

class TimeSelect extends StatelessWidget {
  final int minute;
  final bool isSelected;
  final TimeSelectCB onTimeSelect;

  const TimeSelect(
      {super.key,
      required this.minute,
      required this.isSelected,
      required this.onTimeSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTimeSelect(minute);
      },
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              )
            : BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.red.shade100,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Text(
          '$minute',
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.background
                : Colors.red.shade100,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
