import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/booking_response_dto.dart';
import 'package:foody_app/dto/response/detailed_restaurant_response_dto.dart';
import 'package:foody_app/dto/response/sitting_time_response_dto.dart';
import 'package:foody_app/dto/response/user_response_dto.dart';
import 'package:foody_app/utils/booking_status.dart';
import 'package:foody_app/utils/bookings_filter.dart';
import 'package:foody_app/utils/roles.dart';

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
      : filter = BookingsFilter.all,
        bookings = [],
        apiError = "",
        bookingsFiltered = List.filled(
          10,
          BookingResponseDto(
            id: 0,
            date: DateTime.now(),
            seats: 0,
            customer: UserResponseDto(
              id: 0,
              email: "matteo@gmail.com",
              name: "Nome",
              surname: "Congome",
              birthDate: DateTime(2003, 09, 23),
              phoneNumber: "",
              avatarUrl: "",
              role: Role.CUSTOMER,
              active: true,
              firebaseCustomToken: null,
            ),
            restaurant: const DetailedRestaurantResponseDto(
              id: 0,
              restaurateurEmail: "",
              name: "Pizzum",
              description: "",
              phoneNumber: "",
              street: "",
              civicNumber: "",
              city: "",
              province: "",
              postalCode: "",
              seats: 0,
              approved: true,
              restaurateurId: 0,
              categories: [],
              photoUrl: '',
              averageRating: 0,
              sittingTimes: [],
              dishes: [],
              reviews: [],
            ),
            sittingTime: SittingTimeResponseDto(
              id: 0,
              start: DateTime.now().copyWith(hour: 10, minute: 00),
              end: DateTime.now().copyWith(hour: 10, minute: 30),
              weekDayInfoId: 0,
            ),
            status: BookingStatus.ACTIVE,
          ),
        ),
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
