import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/add_sitting_times_list/sitting_times_form_list_event.dart';
import 'package:foody_app/bloc/add_sitting_times_list/sitting_times_form_list_state.dart';
import 'package:foody_app/bloc/add_sitting_times_list/sitting_times_form_state.dart';
import 'package:foody_app/dto/request/weekday_info_request_dto.dart';
import 'package:foody_app/dto/response/weekday_info_response_dto.dart';
import 'package:foody_app/utils/call_api.dart';
import 'package:foody_app/utils/sitting_times_steps.dart';

import '../../repository/interface/foody_api_repository.dart';
import '../../routing/constants.dart';
import '../../routing/navigation_service.dart';

class SittingTimesFormListBloc
    extends Bloc<SittingTimesFormListEvent, SittingTimesFormListState> {
  final NavigationService _navigationService = NavigationService();
  final FoodyApiRepository foodyApiRepository;
  final bool isEditing;

  SittingTimesFormListBloc({
    required this.foodyApiRepository,
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
  }

  void _onFormSubmit(
      FormSubmit event, Emitter<SittingTimesFormListState> emit) async {
    List<Future<void>> addSittingTimeApiCalls = [];
    int weekDay = 1;

    for (String weekDayName in state.weekDays.keys) {
      final weekDayState = state.weekDays[weekDayName]!;

      if (weekDayState.accordionsState == null) {
        emit(state.copyWith(
            error: "Per andare avanti devi prima visualizzare: $weekDayName"));
        emit(state.copyWith(error: ""));
        return;
      }

      if (weekDayState.lunchStartTime != null ||
          weekDayState.dinnerStartTime != null) {
        addSittingTimeApiCalls.add(callApi<WeekdayInfoResponseDto>(
          api: () => foodyApiRepository.weekdayInfo.save(WeekdayInfoRequestDto(
            weekDay: weekDay,
            startLaunch: weekDayState.lunchStartTime!,
            endLaunch: weekDayState.lunchEndTime!,
            startDinner: weekDayState.dinnerStartTime!,
            endDinner: weekDayState.dinnerEndTime!,
            sittingTimeStep: SittingTimeStep.values[weekDayState.stepIndex],
          )),
          errorToEmit: (e) => emit(state.copyWith(error: e)),
        ));
      }

      weekDay++;
    }

    await Future.wait(addSittingTimeApiCalls);

    _navigationService.resetToScreen(authenticatedRoute);
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
    emit(state.copyWith(isFetchingWeekdays: true));

    await callApi<List<WeekdayInfoResponseDto>>(
      api: foodyApiRepository.weekdayInfo.getAll,
      onComplete: (response) {
        final Map<String, SittingTimesFormState> weekDays =
            Map.from(state.weekDays);

        for (WeekdayInfoResponseDto weekDay in response) {
          final key = state.weekDays.keys.elementAt(weekDay.weekDay - 1);
          SittingTimesFormState? weekDayState = state.weekDays[key];

          if (weekDayState == null) continue;

          weekDays[key] = weekDayState.copyWith(
            lunchStartTime: weekDay.startLaunch,
            lunchEndTime: weekDay.endLaunch,
            dinnerStartTime: weekDay.startDinner,
            dinnerEndTime: weekDay.endDinner,
            stepIndex: weekDay.sittingTimeStep.index,
          );
        }

        emit(state.copyWith(weekDays: weekDays, isFetchingWeekdays: false));
      },
      errorToEmit: (msg) => emit(state.copyWith(error: msg)),
    );
  }
}
