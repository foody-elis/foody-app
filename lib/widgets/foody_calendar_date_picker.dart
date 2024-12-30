import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/dto/response/sitting_time_response_dto.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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

  bool isSelectable(DateTime date) {
    final now = DateTime.now();

    final isTodayOrAfter = (date.year == now.year &&
            date.month == now.month &&
            date.day == now.day) ||
        date.isAfter(now);

    if (sittingTimesForWeekDays == null) {
      return isTodayOrAfter;
    }

    return isTodayOrAfter && sittingTimesForWeekDays![date.weekday]!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        disableMonthPicker: true,
        disableModePicker: true,
        centerAlignModePicker: true,
        firstDayOfWeek: 1,
        disableVibration: true,
        lastMonthIcon: const Icon(PhosphorIconsRegular.caretLeft),
        nextMonthIcon: const Icon(PhosphorIconsRegular.caretRight),
        // monthTextStyle: TextStyle(fontSize: ),
        controlsTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          // color: Theme.of(context).primaryColor,
        ),

        dayBuilder: ({
          required date,
          textStyle,
          decoration,
          isSelected,
          isDisabled,
          isToday,
        }) {
          final canSelect = isSelectable(date);

          return Container(
            // decoration: decoration,
            // width: 20,
            // height: 30,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: canSelect
                  ? Theme.of(context).primaryColor.withOpacity(0.1)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: canSelect ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    MaterialLocalizations.of(context).formatDecimal(date.day),
                    style: textStyle?.copyWith(
                      // fontSize: 13,
                      color: canSelect ? Theme.of(context).primaryColor : null,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isToday == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: canSelect
                              ? Theme.of(context).primaryColor
                              : Colors.grey[500],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        selectableDayPredicate: (date) => isSelectable(date),
        daySplashColor: Colors.transparent,
      ),
      value: value,
      onValueChanged: onValueChanged,
    );
  }
}
