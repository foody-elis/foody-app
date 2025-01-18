import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/sitting_times_form_list/sitting_times_form_list_event.dart';
import 'package:foody_app/bloc/sitting_times_form_list/sitting_times_form_list_state.dart';
import 'package:foody_app/bloc/sitting_times_form_list/sitting_times_form_state.dart';
import 'package:foody_app/dto/request/weekday_info_update_request_dto.dart';
import 'package:foody_app/dto/response/weekday_info_response_dto.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/utils/call_api.dart';
import 'package:foody_app/utils/sitting_times_steps.dart';

import '../../repository/interface/foody_api_repository.dart';
import '../../routing/constants.dart';
import '../../routing/navigation_service.dart';

class SittingTimesFormListBloc
    extends Bloc<SittingTimesFormListEvent, SittingTimesFormListState> {
  final NavigationService _navigationService = NavigationService();
  final FoodyApiRepository foodyApiRepository;
  final UserRepository userRepository;
  final bool isEditing;
  late final int _restaurantId;

  SittingTimesFormListBloc({
    required this.foodyApiRepository,
    required this.userRepository,
    this.isEditing = false,
  }) : super(SittingTimesFormListState.initial()) {
    on<FormSubmit>(_onFormSubmit, transformer: droppable());
    on<AccordionStateChanged>(_onAccordionStateChanged);
    on<LunchTimeChanged>(_onLunchTimeChanged);
    on<DinnerTimeChanged>(_onDinnerTimeChanged);
    on<StepIndexChanged>(_onActiveIndexChanged);
    on<FetchWeekdays>(_onFetchWeekdays);

    if (isEditing) {
      add(FetchWeekdays());
    }

    _restaurantId = userRepository.get()!.restaurantId!;
  }

  void _onFormSubmit(
      FormSubmit event, Emitter<SittingTimesFormListState> emit) async {
    List<Future<void>> sittingTimeApiCalls = [];
    int weekDay = 1;

    for (String weekDayName in state.weekDays.keys) {
      final weekDayState = state.weekDays[weekDayName]!;

      if (!isEditing) {
        if (weekDayState.accordionsState == null) {
          emit(state.copyWith(
              error:
                  "Per andare avanti devi prima visualizzare: $weekDayName"));
          emit(state.copyWith(error: ""));
          return;
        }
      }

      final body = WeekdayInfoUpdateRequestDto(
        startLaunch: weekDayState.lunchStartTime,
        endLaunch: weekDayState.lunchEndTime,
        startDinner: weekDayState.dinnerStartTime,
        endDinner: weekDayState.dinnerEndTime,
        sittingTimeStep: SittingTimeStep.values[weekDayState.stepIndex],
      );

      if (weekDayState.lunchStartTime != null ||
          weekDayState.dinnerStartTime != null) {
        sittingTimeApiCalls.add(
          callApi<WeekdayInfoResponseDto>(
            api: () => isEditing
                ? foodyApiRepository.weekdayInfo.update(weekDayState.id!, body)
                : foodyApiRepository.weekdayInfo.save(
                    body.toWeekdayInfoRequestDto(
                      weekDay: weekDay,
                      restaurantId: _restaurantId,
                    ),
                  ),
            errorToEmit: (e) => emit(state.copyWith(error: e)),
            throwException: true,
          ),
        );
      }

      weekDay++;
    }

    emit(state.copyWith(isLoading: true));

    try {
      await Future.wait(sittingTimeApiCalls);

      if (isEditing) {
        emit(state.copyWith(error: "Orari aggiornati con successo"));
      }

      _navigationService.resetToScreen(authenticatedRoute);
    } catch (_) {}

    emit(state.copyWith(isLoading: false));
  }

  void _onLunchTimeChanged(
      LunchTimeChanged event, Emitter<SittingTimesFormListState> emit) {
    final Map<String, SittingTimesFormState> weekDays =
        Map.from(state.weekDays);

    weekDays[event.weekDay] = state.weekDays[event.weekDay]!.copyWith(
      lunchStartTime: event.startTime ?? "null",
      lunchEndTime: event.endTime ?? "null",
    );

    emit(state.copyWith(weekDays: weekDays));
  }

  void _onDinnerTimeChanged(
      DinnerTimeChanged event, Emitter<SittingTimesFormListState> emit) {
    final Map<String, SittingTimesFormState> weekDays =
        Map.from(state.weekDays);

    weekDays[event.weekDay] = state.weekDays[event.weekDay]!.copyWith(
      dinnerStartTime: event.startTime ?? "null",
      dinnerEndTime: event.endTime ?? "null",
    );

    emit(state.copyWith(weekDays: weekDays));
  }

  void _onAccordionStateChanged(
      AccordionStateChanged event, Emitter<SittingTimesFormListState> emit) {
    final Map<String, SittingTimesFormState> weekDays =
        Map.from(state.weekDays);

    if (!event.state) {
      weekDays[event.weekDay] = state.weekDays[event.weekDay]!.copyWith(
        accordionsState: false,
      );
    } else {
      weekDays.updateAll((weekDay, weekDayState) => weekDay == event.weekDay
          ? weekDayState.copyWith(accordionsState: true)
          : weekDayState.accordionsState != null
              ? weekDayState.copyWith(accordionsState: false)
              : weekDayState);
    }

    emit(state.copyWith(weekDays: weekDays));
  }

  void _onActiveIndexChanged(
      StepIndexChanged event, Emitter<SittingTimesFormListState> emit) {
    final Map<String, SittingTimesFormState> weekDays =
        Map.from(state.weekDays);

    weekDays[event.weekDay] = state.weekDays[event.weekDay]!.copyWith(
      stepIndex: event.stepIndex,
    );

    emit(state.copyWith(weekDays: weekDays));
  }

  void _onFetchWeekdays(
      FetchWeekdays event, Emitter<SittingTimesFormListState> emit) async {
    emit(state.copyWith(isLoading: true));

    await callApi<List<WeekdayInfoResponseDto>>(
      api: () => foodyApiRepository.weekdayInfo.getByRestaurant(_restaurantId),
      onComplete: (response) {
        final Map<String, SittingTimesFormState> weekDays = Map.from(
          state.weekDays
              .map((k, v) => MapEntry(k, v.copyWith(accordionsState: false))),
        );

        for (WeekdayInfoResponseDto weekDay in response) {
          final key = state.weekDays.keys.elementAt(weekDay.weekDay - 1);
          SittingTimesFormState? weekDayState = state.weekDays[key];

          if (weekDayState == null) continue;

          weekDays[key] = weekDayState.copyWith(
            id: weekDay.id,
            lunchStartTime: weekDay.startLaunch,
            lunchEndTime: weekDay.endLaunch,
            dinnerStartTime: weekDay.startDinner,
            dinnerEndTime: weekDay.endDinner,
            stepIndex: weekDay.sittingTimeStep.index,
            accordionsState: false,
          );
        }

        emit(state.copyWith(weekDays: weekDays, isLoading: false));
      },
      errorToEmit: (msg) => emit(state.copyWith(error: msg)),
    );
  }
}
