import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class FoodyCalendarDatePicker extends StatelessWidget {
  const FoodyCalendarDatePicker({
    super.key,
    required this.value,
    this.onValueChanged,
  });

  final List<DateTime?> value;
  final void Function(List<DateTime>)? onValueChanged;

  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        disableMonthPicker: true,
        disableModePicker: true,
        centerAlignModePicker: true,
        firstDayOfWeek: 1,
        disableVibration: true,
        selectableDayPredicate: (date) {
          final now = DateTime.now();
          return date.day == now.day || date.isAfter(now);
        },
        daySplashColor: Colors.transparent,
      ),
      value: value,
      onValueChanged: onValueChanged,
    );
  }
}
