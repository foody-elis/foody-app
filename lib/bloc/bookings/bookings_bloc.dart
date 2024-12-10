import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/bookings/bookings_event.dart';
import 'package:foody_app/bloc/bookings/bookings_state.dart';
import 'package:foody_app/dto/response/booking_response_dto.dart';
import 'package:foody_app/utils/booking_status.dart';
import 'package:foody_app/utils/bookings_filter.dart';

import '../../repository/interface/foody_api_repository.dart';
import '../../utils/call_api.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final FoodyApiRepository foodyApiRepository;

  BookingsBloc({required this.foodyApiRepository})
      : super(BookingsState.initial()) {
    on<FetchBookings>(_onFetchBookings, transformer: droppable());
    on<FilterChanged>(_onFilterChanged);
  }

  void _onFetchBookings(
      FetchBookings event, Emitter<BookingsState> emit) async {
    emit(state.copyWith(isFetching: true));

    await callApi<List<BookingResponseDto>>(
      api: () => event.restaurantId == null
          ? foodyApiRepository.bookings.getByCustomer()
          : foodyApiRepository.bookings.getByRestaurant(event.restaurantId!),
      onComplete: (response) {
        emit(state.copyWith(bookings: response));
        _applyFilter(emit);
      },
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isFetching: false));
  }

  bool _equalDays(DateTime date1, {DateTime? date2}) {
    date2 ??= DateTime.now();

    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isToday(DateTime date) => _equalDays(date, date2: DateTime.now());

  bool _isYesterday(DateTime date) =>
      _equalDays(date, date2: DateTime.now().subtract(const Duration(days: 1)));

  bool _isTomorrow(DateTime date) =>
      _equalDays(date, date2: DateTime.now().add(const Duration(days: 1)));

  void _applyFilter(Emitter<BookingsState> emit) {
    emit(state.copyWith(
      bookingsFiltered: state.bookings
          .where(
            (b) => switch (state.filter) {
              BookingsFilter.today => _isToday(b.date),
              BookingsFilter.yesterday => _isYesterday(b.date),
              BookingsFilter.tomorrow => _isTomorrow(b.date),
              BookingsFilter.all => true,
              BookingsFilter.active => b.status == BookingStatus.ACTIVE,
              BookingsFilter.canceled => b.status == BookingStatus.CANCELLED,
            },
          )
          .toList(),
    ));
  }

  void _onFilterChanged(FilterChanged event, Emitter<BookingsState> emit) {
    emit(state.copyWith(filter: event.filter));
    _applyFilter(emit);
  }
}
