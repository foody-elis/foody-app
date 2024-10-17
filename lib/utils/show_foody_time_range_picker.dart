import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

void Function() showFoodyTimeRangePicker({
  required BuildContext context,
  required void Function(DateTime startTime, DateTime endTime) onSubmit,
  DateTime? lastDateTime,
}) {
  final defaultStart =
      lastDateTime ?? DateTime.now().copyWith(hour: 0, minute: 0);
  final defaultEnd = lastDateTime?.add(const Duration(hours: 2)) ??
      DateTime.now().copyWith(hour: 2, minute: 0);

  return () async {
    TimeRange? result = await showTimeRangePicker(
      context: context,
      start: TimeOfDay.fromDateTime(defaultStart),
      end: TimeOfDay.fromDateTime(defaultEnd),
      interval: const Duration(minutes: 15),
      minDuration: const Duration(minutes: 15),
      strokeWidth: 4,
      ticks: 24,
      padding: 40,
      ticksOffset: -4,
      ticksLength: 12,
      ticksColor: Colors.grey,
      snap: true,
      fromText: "Dalle",
      toText: "Alle",
      handlerRadius: 9,
      selectedColor: Colors.grey,
      labels:
          ["0", "3", "6", "9", "12", "15", "18", "21"].asMap().entries.map((e) {
        return ClockLabel.fromIndex(
          idx: e.key,
          length: 8,
          text: e.value,
        );
      }).toList(),
      clockRotation: 180,
      // labelOffset: 30,
      labelStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
    );

    if (/*context.mounted && */result != null) {

      final startTime = DateTime.now().copyWith(
        hour: result.startTime.hour,
        minute: result.startTime.minute,
      );
      final endTime = DateTime.now().copyWith(
        hour: result.endTime.hour,
        minute: result.endTime.minute,
      );

      onSubmit(startTime, endTime);
    }
  };
}
