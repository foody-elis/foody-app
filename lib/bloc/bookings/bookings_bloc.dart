import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/bookings/bookings_event.dart';
import 'package:foody_app/bloc/bookings/bookings_state.dart';
import 'package:foody_app/dto/response/booking_response_dto.dart';
import 'package:foody_app/utils/booking_status.dart';
import 'package:foody_app/utils/bookings_filter.dart';

import '../../repository/interface/foody_api_repository.dart';
import '../../utils/call_api.dart';
import '../../utils/date_comparisons.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final FoodyApiRepository foodyApiRepository;

  BookingsBloc({required this.foodyApiRepository})
      : super(BookingsState.initial()) {
    on<FetchBookings>(_onFetchBookings, transformer: droppable());
    on<CancelBooking>(_onCancelBooking, transformer: droppable());
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
      onFailed: (_) => emit(state.copyWith(bookings: [], bookingsFiltered: [])),
      onError: () => emit(state.copyWith(bookings: [], bookingsFiltered: [])),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isFetching: false));
  }

  void _applyFilter(Emitter<BookingsState> emit) {
    emit(state.copyWith(
      bookingsFiltered: state.bookings
          .where(
            (b) => switch (state.filter) {
              BookingsFilter.today => isToday(b.date),
              BookingsFilter.yesterday => isYesterday(b.date),
              BookingsFilter.all => true,
              BookingsFilter.active => b.status == BookingStatus.ACTIVE,
              BookingsFilter.canceled => b.status == BookingStatus.CANCELLED,
            },
          )
          .toList()
        ..sort((a, b) {
          if (a.status != b.status) {
            return a.status == BookingStatus.ACTIVE ? -1 : 1;
          }

          return a.date.compareTo(b.date);
        }),
    ));
  }

  void _onFilterChanged(FilterChanged event, Emitter<BookingsState> emit) {
    emit(state.copyWith(filter: event.filter));
    _applyFilter(emit);
  }

  void _onCancelBooking(
      CancelBooking event, Emitter<BookingsState> emit) async {
    emit(state.copyWith(isFetching: true));

    await callApi<BookingResponseDto>(
      api: () => foodyApiRepository.bookings.cancel(event.id),
      onComplete: (response) => add(const FetchBookings()),
      onFailed: (_) => emit(state.copyWith(bookings: [], bookingsFiltered: [])),
      onError: () => emit(state.copyWith(bookings: [], bookingsFiltered: [])),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isFetching: false));
  }
}
