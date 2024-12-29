import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_event.dart';
import 'package:foody_app/bloc/booking_form/booking_form_state.dart';
import 'package:foody_app/dto/request/booking_request_dto.dart';
import 'package:foody_app/dto/response/booking_response_dto.dart';
import 'package:foody_app/dto/response/restaurant_response_dto.dart';
import 'package:foody_app/dto/response/sitting_time_response_dto.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:foody_app/routing/navigation_service.dart';

import '../../repository/interface/foody_api_repository.dart';
import '../../utils/call_api.dart';

class BookingFormBloc extends Bloc<BookingFormEvent, BookingFormState> {
  final FoodyApiRepository foodyApiRepository;
  final RestaurantResponseDto restaurant;
  final SittingTimeResponseDto? sittingTime;
  final NavigationService _navigationService = NavigationService();

  BookingFormBloc({
    required this.foodyApiRepository,
    required this.restaurant,
    required this.sittingTime,
  }) : super(BookingFormState.initial(sittingTime)) {
    on<Submit>(_onSubmit, transformer: droppable());
    on<FetchSittingTimes>(_onFetchSittingTimes, transformer: droppable());
    on<DateChanged>(_onDateChanged);
    on<SittingTimeChanged>(_onSittingTimeChanged);
    on<SeatsChanged>(_onSeatsChanged);
    on<StepChanged>(_onStepChanged);
    on<PreviousStep>(_onPreviousStep);

    add(FetchSittingTimes());
  }

  void _onFetchSittingTimes(
      FetchSittingTimes event, Emitter<BookingFormState> emit) async {
    List<Future<void>> fetchSittingTimesByWeekDayFutures = [];
    final sittingTimesForWeekDays = Map.of(state.sittingTimesForWeekDays);

    for (int weekDay in state.sittingTimesForWeekDays.keys) {
      fetchSittingTimesByWeekDayFutures
          .add(callApi<List<SittingTimeResponseDto>>(
        api: () => foodyApiRepository.sittingTimes
            .getAllByRestaurantAndWeekDay(restaurant.id, weekDay),
        onComplete: (sittingTimes) {
          final now = DateTime.now();

          if (now.weekday == weekDay) {
            sittingTimesForWeekDays[weekDay] = sittingTimes
                .where((sittingTime) =>
                    sittingTime.start.hour > now.hour ||
                    sittingTime.start.hour == now.hour &&
                        sittingTime.start.minute > now.minute)
                .toList();
          } else {
            sittingTimesForWeekDays[weekDay] = sittingTimes;
          }
        },
        errorToEmit: (e) => emit(state.copyWith(apiError: e)),
        throwException: true,
      ));
    }

    emit(state.copyWith(isLoading: true));

    try {
      await Future.wait(fetchSittingTimesByWeekDayFutures);
      emit(state.copyWith(sittingTimesForWeekDays: sittingTimesForWeekDays));
    } catch (_) {}

    emit(state.copyWith(isLoading: false));
  }

  void _onSubmit(Submit event, Emitter<BookingFormState> emit) async {
    emit(state.copyWith(isLoading: true));

    await callApi<BookingResponseDto>(
      api: () => foodyApiRepository.bookings.save(
        BookingRequestDto(
          date: state.date!,
          seats: state.seats!,
          sittingTimeId: state.sittingTime!.id,
          restaurantId: restaurant.id,
        ),
      ),
      onComplete: (booking) => _navigationService.replaceScreen(
        bookingCompletedRoute,
        arguments: {"booking": booking},
      ),
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isLoading: false));
  }

  void _onDateChanged(DateChanged event, Emitter<BookingFormState> emit) async {
    emit(state.copyWith(date: event.date, activeStep: 1));
  }

  void _onSittingTimeChanged(
      SittingTimeChanged event, Emitter<BookingFormState> emit) {
    emit(state.copyWith(sittingTime: event.sittingTime, activeStep: 2));
  }

  void _onSeatsChanged(SeatsChanged event, Emitter<BookingFormState> emit) {
    emit(state.copyWith(seats: event.seats, activeStep: 3));
  }

  void _onStepChanged(StepChanged event, Emitter<BookingFormState> emit) {
    emit(state.copyWith(activeStep: event.step));
    _clearStepValue(emit);
  }

  void _onPreviousStep(PreviousStep event, Emitter<BookingFormState> emit) {
    if (state.activeStep == 0) {
      _navigationService.goBack();
    } else {
      emit(state.copyWith(activeStep: state.activeStep - 1));
      _clearStepValue(emit);
    }
  }

  void _clearStepValue(Emitter<BookingFormState> emit) {
    if (state.activeStep == 0) {
      emit(state.copyWith(date: "null", sittingTime: "null", seats: -1));
    } else if (state.activeStep == 1) {
      emit(state.copyWith(sittingTime: "null", seats: -1));
    } else if (state.activeStep == 2) {
      emit(state.copyWith(seats: -1));
    }
  }
}
