enum BookingsFilter { all, future, past, active, canceled }

extension BookingsFilterExtension on BookingsFilter {
  String get label => switch (this) {
        BookingsFilter.all => "Tutte",
        BookingsFilter.future => "Future",
        BookingsFilter.past => "Passate",
        BookingsFilter.active => "Attive",
        BookingsFilter.canceled => "Cancellate",
      };
}
