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

bool isPast(DateTime booking, DateTime sittingTime) {
  final endBooking = booking.copyWith(
    hour: sittingTime.hour,
    minute: sittingTime.minute,
  );

  return DateTime.now().isAfter(endBooking);
}

bool isFuture(DateTime booking, DateTime sittingTime) =>
    !isPast(booking, sittingTime);
