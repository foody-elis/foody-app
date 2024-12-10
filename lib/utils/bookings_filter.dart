enum BookingsFilter { today, yesterday, tomorrow, all, active, canceled }

extension BookingsFilterExtension on BookingsFilter {
  String get label => switch (this) {
        BookingsFilter.today => "Oggi",
        BookingsFilter.yesterday => "Ieri",
        BookingsFilter.tomorrow => "Domani",
        BookingsFilter.all => "Tutte",
        BookingsFilter.active => "Attive",
        BookingsFilter.canceled => "Cancellate",
      };
}
