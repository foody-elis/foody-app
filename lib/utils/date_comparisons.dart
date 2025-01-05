bool _equalDays(DateTime date1, {DateTime? date2}) {
  date2 ??= DateTime.now();

  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

bool isToday(DateTime date) => _equalDays(date, date2: DateTime.now());

bool isYesterday(DateTime date) => _equalDays(
      date,
      date2: DateTime.now().subtract(const Duration(days: 1)),
    );
