enum BookingsFilter { all, active, past, canceled }

extension BookingsFilterExtension on BookingsFilter {
  String get label => switch (this) {
        BookingsFilter.all => "Tutte",
        BookingsFilter.active => "Attive",
        BookingsFilter.past => "Passate",
        BookingsFilter.canceled => "Cancellate",
      };
}
