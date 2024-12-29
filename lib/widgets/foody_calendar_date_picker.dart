import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/dto/response/sitting_time_response_dto.dart';

class FoodyCalendarDatePicker extends StatelessWidget {
  const FoodyCalendarDatePicker({
    super.key,
    required this.value,
    this.onValueChanged,
    this.sittingTimesForWeekDays,
  });

  final List<DateTime?> value;
  final void Function(List<DateTime>)? onValueChanged;
  final Map<int, List<SittingTimeResponseDto>>? sittingTimesForWeekDays;

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
          final isTodayOrAfter = (date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day) ||
              date.isAfter(now);

          if (sittingTimesForWeekDays == null) {
            return isTodayOrAfter;
          }

          return isTodayOrAfter &&
              sittingTimesForWeekDays![date.weekday]!.isNotEmpty;
        },
        daySplashColor: Colors.transparent,
      ),
      value: value,
      onValueChanged: onValueChanged,
    );
  }
}
