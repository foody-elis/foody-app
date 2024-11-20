import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/widgets/foody_button.dart';
import 'package:foody_app/widgets/foody_outlined_button.dart';
import 'package:foody_app/widgets/foody_text_field.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../hooks/fixed_extent_scroll_controller_hook.dart';

class FoodyDatePicker extends HookWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final void Function(DateTime dateTime)? onChanged;
  final bool required;
  final EdgeInsetsGeometry? padding, margin;
  final String? errorText;

  FoodyDatePicker({
    super.key,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    this.onChanged,
    this.required = false,
    this.margin,
    this.padding,
    this.errorText,
  })  : firstDate = firstDate ?? DateTime(1900, 1, 1),
        lastDate = lastDate ??= DateTime.now(),
        initialDate = initialDate ?? lastDate;

  @override
  Widget build(BuildContext context) {
    final selectedDate = useState<DateTime>(initialDate);
    final isSelected = useState<bool>(false);

    void onShowCalendarClick() async {
      final res = await showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return _CalendarView(
            selectedDate: selectedDate.value,
            firstDate: firstDate,
            lastDate: lastDate,
          );
        },
      );

      if (res is DateTime) {
        selectedDate.value = res;
        isSelected.value = true;
        onChanged?.call(res);
      }
    }

    return Container(
      padding: padding,
      margin: margin,
      child: FoodyTextField(
        title: "Data di nascita",
        hint: "-- / -- / ----",
        label: isSelected.value ? DateFormat('dd/MM/yyyy').format(selectedDate.value) : '',
        onTap: onShowCalendarClick,
        suffixIcon: const Icon(PhosphorIconsRegular.calendarDots),
        showCursor: false,
        readOnly: true,
        required: required,
        errorText: errorText,
      ),
    );
  }
}

class _CalendarView extends HookWidget {
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const _CalendarView({
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    final currentDate = useState<DateTime>(selectedDate);

    List<int> getDaysInMonth(int year, int month) {
      if (lastDate.year == currentDate.value.year &&
          lastDate.month == currentDate.value.month) {
        return List.generate(lastDate.day, (index) => index + 1);
      } else {
        int numDays = switch (month) {
          1 || 3 || 5 || 7 || 8 || 10 || 12 => 31,
          2 => (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 ? 29 : 28,
          _ => 30
        };
        return List.generate(numDays, (index) => index + 1);
      }
    }

    List<String> getMonths() {
      final months = [
        'Gennaio',
        'Febbraio',
        'Marzo',
        'Aprile',
        'Maggio',
        'Giugno',
        'Luglio',
        'Agosto',
        'Settembre',
        'Ottobre',
        'Novembre',
        'Dicembre'
      ];

      if (lastDate.year == currentDate.value.year) {
        return months.sublist(0, lastDate.month);
      } else {
        return months;
      }
    }

    final days =
        getDaysInMonth(currentDate.value.year, currentDate.value.month);
    final months = getMonths();
    final years = _getYears();

    final yearController = useFixedExtentScrollController(
        initialItem: _getYears().indexOf(currentDate.value.year));
    final monthController = useFixedExtentScrollController(
        initialItem: months.indexOf(months[currentDate.value.month - 1]));
    final dayController =
        useFixedExtentScrollController(initialItem: currentDate.value.day - 1);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 35 / 100,
            margin: const EdgeInsets.only(bottom: 20),
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Text(
            DateFormat('dd / MM / yyyy').format(currentDate.value.toLocal()),
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          const Divider(thickness: 1),
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker.builder(
                    scrollController: dayController,
                    diameterRatio: 1.0,
                    itemExtent: 60,
                    onSelectedItemChanged: (value) {
                      currentDate.value =
                          currentDate.value.copyWith(day: value + 1);
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          days[index].toString(),
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      );
                    },
                    childCount: days.length,
                  ),
                ),
                Expanded(
                  child: CupertinoPicker.builder(
                    scrollController: monthController,
                    diameterRatio: 1.0,
                    itemExtent: 60,
                    onSelectedItemChanged: (value) {
                      final daysInMonth = getDaysInMonth(
                        currentDate.value.year,
                        value + 1,
                      );

                      if (currentDate.value.day > daysInMonth.length) {
                        currentDate.value =
                            currentDate.value.copyWith(day: daysInMonth.length);
                      }

                      currentDate.value =
                          currentDate.value.copyWith(month: value + 1);
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          months[index],
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      );
                    },
                    childCount: months.length,
                  ),
                ),
                Expanded(
                  child: CupertinoPicker.builder(
                    scrollController: yearController,
                    diameterRatio: 1.0,
                    itemExtent: 60,
                    onSelectedItemChanged: (value) {
                      currentDate.value =
                          currentDate.value.copyWith(year: _getYears()[value]);

                      if (currentDate.value.month > lastDate.month) {
                        currentDate.value = currentDate.value
                            .copyWith(month: getMonths().length);
                      }

                      List<int> daysInMonth = getDaysInMonth(
                          currentDate.value.year, currentDate.value.month);

                      if (currentDate.value.day > daysInMonth.length) {
                        currentDate.value =
                            currentDate.value.copyWith(day: daysInMonth.last);
                      }
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          years[index].toString(),
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      );
                    },
                    childCount: years.length,
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: FoodyOutlinedButton(
                  label: 'Annulla',
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: FoodyButton(
                  label: 'Seleziona',
                  onPressed: () => Navigator.pop(context, currentDate.value),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<int> _getYears() {
    final startYear = firstDate.year;
    final endYear = lastDate.year;

    return List.generate(endYear - startYear + 1, (index) => startYear + index);
  }
}
