import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/add_sitting_times_list/add_sitting_times_state.dart';
import 'package:foody_app/dto/request/weekday_info_request_dto.dart';
import 'package:foody_app/dto/response/weekday_info_response_dto.dart';
import 'package:foody_app/utils/call_api.dart';
import 'package:foody_app/utils/sitting_times_steps.dart';

import '../../repository/interface/foody_api_repository.dart';
import '../../routing/constants.dart';
import '../../routing/navigation_service.dart';
import 'add_sitting_times_list_event.dart';
import 'add_sitting_times_list_state.dart';

class AddSittingTimesListBloc
    extends Bloc<AddSittingTimesListEvent, AddSittingTimesListState> {
  final NavigationService _navigationService = NavigationService();
  final FoodyApiRepository foodyApiRepository;

  AddSittingTimesListBloc({required this.foodyApiRepository})
      : super(AddSittingTimesListState.initial()) {
    on<FormSubmit>(_onFormSubmit, transformer: droppable());
    on<AccordionStateChanged>(_onAccordionStateChanged);
    on<LunchTimeChanged>(_onLunchTimeChanged);
    on<DinnerTimeChanged>(_onDinnerTimeChanged);
    on<StepIndexChanged>(_onActiveIndexChanged);
  }

  void _onFormSubmit(
      FormSubmit event, Emitter<AddSittingTimesListState> emit) async {
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
          api: foodyApiRepository.weekdayInfo.save,
          data: WeekdayInfoRequestDto(
            weekDay: weekDay,
            startLaunch: weekDayState.lunchStartTime!,
            endLaunch: weekDayState.lunchEndTime!,
            startDinner: weekDayState.dinnerStartTime!,
            endDinner: weekDayState.dinnerEndTime!,
            sittingTimeStep: SittingTimeStep.values[weekDayState.stepIndex],
          ),
          errorToEmit: (e) => emit(state.copyWith(error: e)),
        ));
      }

      weekDay++;
    }

    await Future.wait(addSittingTimeApiCalls);

    _navigationService.resetToScreen(authenticatedRoute);
  }

  void _onLunchTimeChanged(
      LunchTimeChanged event, Emitter<AddSittingTimesListState> emit) {
    final Map<String, AddSittingTimesState> weekDays = Map.from(state.weekDays);

    weekDays[event.weekDay] = state.weekDays[event.weekDay]!.copyWith(
      lunchStartTime: event.startTime ?? "null",
      lunchEndTime: event.endTime ?? "null",
    );

    emit(state.copyWith(weekDays: weekDays));
  }

  void _onDinnerTimeChanged(
      DinnerTimeChanged event, Emitter<AddSittingTimesListState> emit) {
    final Map<String, AddSittingTimesState> weekDays = Map.from(state.weekDays);

    weekDays[event.weekDay] = state.weekDays[event.weekDay]!.copyWith(
      dinnerStartTime: event.startTime ?? "null",
      dinnerEndTime: event.endTime ?? "null",
    );

    emit(state.copyWith(weekDays: weekDays));
  }

  void _onAccordionStateChanged(
      AccordionStateChanged event, Emitter<AddSittingTimesListState> emit) {
    final Map<String, AddSittingTimesState> weekDays = Map.from(state.weekDays);

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
      StepIndexChanged event, Emitter<AddSittingTimesListState> emit) {
    final Map<String, AddSittingTimesState> weekDays = Map.from(state.weekDays);

    weekDays[event.weekDay] = state.weekDays[event.weekDay]!.copyWith(
      stepIndex: event.stepIndex,
    );

    emit(state.copyWith(weekDays: weekDays));
  }
}
