enum BookingsFilter {  all, today, yesterday, active, canceled }

extension BookingsFilterExtension on BookingsFilter {
  String get label => switch (this) {
        BookingsFilter.all => "Tutte",
        BookingsFilter.today => "Oggi",
        BookingsFilter.yesterday => "Ieri",
        BookingsFilter.active => "Attive",
        BookingsFilter.canceled => "Cancellate",
      };
}
