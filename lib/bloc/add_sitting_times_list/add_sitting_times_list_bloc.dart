import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/add_sitting_times_list/add_sitting_times_state.dart';
import 'package:foody_app/routing/constants.dart';

import '../../routing/navigation_service.dart';
import 'add_sitting_times_list_event.dart';
import 'add_sitting_times_list_state.dart';

class AddSittingTimesListBloc
    extends Bloc<AddSittingTimesListEvent, AddSittingTimesListState> {
  final NavigationService _navigationService = NavigationService();

  AddSittingTimesListBloc() : super(AddSittingTimesListState.initial()) {
    on<FormSubmit>(_onFormSubmit, transformer: droppable());
    on<AccordionStateChanged>(_onAccordionStateChanged);
    on<LunchTimeChanged>(_onLunchTimeChanged);
    on<DinnerTimeChanged>(_onDinnerTimeChanged);
    on<ActiveIndexChanged>(_onActiveIndexChanged);
  }

  void _onFormSubmit(FormSubmit event, Emitter<AddSittingTimesListState> emit) {
    for (String weekDay in state.weekDays.keys) {
      final weekDayState = state.weekDays[weekDay]!;

      if (weekDayState.accordionsState == null) {
        emit(state.copyWith(
            error: "Per andare avanti devi prima visualizzare: $weekDay"));
        emit(state.copyWith(error: ""));
        return;
      }
    }

    _navigationService.resetToScreen(homeRoute);
  }

  void _onLunchTimeChanged(
      LunchTimeChanged event, Emitter<AddSittingTimesListState> emit) {
    final Map<String, AddSittingTimesState> weekDays = Map.from(state.weekDays);

    weekDays[event.weekDay] = state.weekDays[event.weekDay]!.copyWith(
      lunchStartTime: event.startTime,
      lunchEndTime: event.endTime,
    );

    emit(state.copyWith(weekDays: weekDays));
  }

  void _onDinnerTimeChanged(
      DinnerTimeChanged event, Emitter<AddSittingTimesListState> emit) {
    final Map<String, AddSittingTimesState> weekDays = Map.from(state.weekDays);

    weekDays[event.weekDay] = state.weekDays[event.weekDay]!.copyWith(
      dinnerStartTime: event.startTime,
      dinnerEndTime: event.endTime,
    );

    emit(state.copyWith(weekDays: weekDays));
  }

  void _onAccordionStateChanged(
      AccordionStateChanged event, Emitter<AddSittingTimesListState> emit) {
    final Map<String, AddSittingTimesState> weekDays = Map.from(state.weekDays);

    weekDays[event.weekDay] = state.weekDays[event.weekDay]!.copyWith(
      accordionsState: event.state,
    );

    emit(state.copyWith(weekDays: weekDays));
  }

  void _onActiveIndexChanged(
      ActiveIndexChanged event, Emitter<AddSittingTimesListState> emit) {
    final Map<String, AddSittingTimesState> weekDays = Map.from(state.weekDays);

    weekDays[event.weekDay] = state.weekDays[event.weekDay]!.copyWith(
      activeIndex: event.activeIndex,
    );

    emit(state.copyWith(weekDays: weekDays));
  }
}
