import 'package:equatable/equatable.dart';
import 'package:foody_api_client/dto/response/booking_response_dto.dart';
import 'package:foody_app/utils/bookings_filter.dart';
import 'package:foody_app/utils/skeletonizer_data/fake_booking.dart';

class BookingsState extends Equatable {
  final BookingsFilter filter;
  final List<BookingResponseDto> bookings;
  final List<BookingResponseDto> bookingsFiltered;
  final String apiError;
  final bool isFetching;

  const BookingsState({
    required this.filter,
    required this.bookings,
    required this.apiError,
    required this.bookingsFiltered,
    required this.isFetching,
  });

  BookingsState.initial()
      : filter = BookingsFilter.active,
        bookings = [],
        apiError = "",
        bookingsFiltered = List.filled(10, getFakeBooking()),
        isFetching = true;

  BookingsState copyWith({
    BookingsFilter? filter,
    List<BookingResponseDto>? bookings,
    List<BookingResponseDto>? bookingsFiltered,
    String? apiError,
    bool? isFetching,
  }) {
    return BookingsState(
      filter: filter ?? this.filter,
      bookings: bookings ?? this.bookings,
      bookingsFiltered: bookingsFiltered ?? this.bookingsFiltered,
      apiError: apiError ?? this.apiError,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object?> get props => [
        filter,
        bookings,
        bookingsFiltered,
        apiError,
        isFetching,
      ];
}
