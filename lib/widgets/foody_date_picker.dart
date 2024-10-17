import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/widgets/foody_button.dart';
import 'package:foody_app/widgets/foody_outlined_button.dart';
import 'package:foody_app/widgets/foody_text_field.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodyDatePicker extends StatefulWidget {
  /// The currently selected date.
  final DateTime currentDate;

  /// Minimum year that the picker can be scrolled.
  final DateTime firstDate;

  /// Maximum year that the picker an be scrolled.
  final DateTime lastDate;

  /// Get date from user selects a date in the picker.
  final void Function(DateTime dateTime)? onChanged;

  FoodyDatePicker({
    super.key,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? currentDate,
    this.onChanged,
  })  : firstDate = firstDate ?? DateTime(1900, 1, 1),
        lastDate = lastDate ??= DateTime.now(),
        currentDate = currentDate ?? lastDate,
        super();

  @override
  State<FoodyDatePicker> createState() => _FoodyDatePickerState();
}

class _FoodyDatePickerState extends State<FoodyDatePicker>
    with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late DateTime currentDate;

  @override
  void initState() {
    currentDate = widget.currentDate;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FoodyTextField(
      title: "Data di nascita",
      hint: "-- / -- / ----",
      controller: controller,
      onTap: onShowCalendarClick,
      suffixIcon: const Icon(PhosphorIconsRegular.calendarDots),
      showCursor: false,
      readOnly: true,
    );
  }

  void onShowCalendarClick() async {
    final res = await showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return _CalendarView(
          selectedDate: currentDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );
      },
    );

    if (res is DateTime) {
      currentDate = res;
      controller.text = currentDate.toString().split(' ')[0];
      widget.onChanged?.call(currentDate);
    }
  }
}

class _CalendarView extends StatefulWidget {
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const _CalendarView({
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  State<_CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<_CalendarView> {
  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();

    currentDate = widget.selectedDate;

    yearController = FixedExtentScrollController(
        initialItem: _getYears().indexOf(currentDate.year));

    final months = _getMonths();
    monthController = FixedExtentScrollController(
        initialItem: months.indexOf(months[currentDate.month - 1]));

    dayController =
        FixedExtentScrollController(initialItem: currentDate.day - 1);
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth(currentDate.year, currentDate.month);
    final months = _getMonths();
    final years = _getYears();

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
            DateFormat('dd / MM / yyyy').format(currentDate.toLocal()),
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
                      currentDate = currentDate.copyWith(day: value + 1);
                      setState(() {});
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
                      final daysInMonth = _getDaysInMonth(
                        currentDate.year,
                        value + 1,
                      );

                      if (currentDate.day > daysInMonth.length) {
                        currentDate =
                            currentDate.copyWith(day: daysInMonth.length);
                      }

                      currentDate = currentDate.copyWith(month: value + 1);

                      setState(() {});
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
                      currentDate =
                          currentDate.copyWith(year: _getYears()[value]);

                      if (currentDate.month > widget.lastDate.month) {
                        currentDate =
                            currentDate.copyWith(month: _getMonths().length);
                      }

                      List<int> daysInMonth =
                          _getDaysInMonth(currentDate.year, currentDate.month);

                      if (currentDate.day > daysInMonth.length) {
                        currentDate =
                            currentDate.copyWith(day: daysInMonth.last);
                      }

                      setState(() {});
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
                  onPressed: () => Navigator.pop(context, currentDate),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<int> _getDaysInMonth(int year, int month) {
    if (widget.lastDate.year == currentDate.year &&
        widget.lastDate.month == currentDate.month) {
      return List.generate(widget.lastDate.day, (index) => index + 1);
    } else {
      int numDays = switch (month) {
        1 || 3 || 5 || 7 || 8 || 10 || 12 => 31,
        2 => (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 ? 29 : 28,
        _ => 30
      };
      return List.generate(numDays, (index) => index + 1);
    }
  }

  List<int> _getYears() {
    final startYear = widget.firstDate.year;
    final endYear = widget.lastDate.year;

    return List.generate(endYear - startYear + 1, (index) => startYear + index);
  }

  List<String> _getMonths() {
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

    if (widget.lastDate.year == currentDate.year) {
      return months.sublist(0, widget.lastDate.month);
    } else {
      return months;
    }
  }
}
