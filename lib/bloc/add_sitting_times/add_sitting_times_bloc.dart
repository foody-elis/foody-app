import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/dto/sitting_time.dart';
import 'package:foody_app/routing/constants.dart';

import '../../routing/navigation_service.dart';
import 'add_sitting_times_event.dart';
import 'add_sitting_times_state.dart';

class AddSittingTimesBloc
    extends Bloc<AddSittingTimesEvent, AddSittingTimesState> {
  final NavigationService _navigationService = NavigationService();
  final bool defaultIntervals;

  AddSittingTimesBloc({required this.defaultIntervals})
      : super(AddSittingTimesState.initial(defaultIntervals)) {
    on<FormSubmit>(_onFormSubmit, transformer: droppable());
    on<ClearSittingTimes>(_onClearSittingTimes);
    on<CustomSittingTimeAdded>(_onCustomSittingTimeAdded);
    on<Add30MinutesSittingTime>(_onAdd30MinutesSittingTime);
    on<Add1HourSittingTime>(_onAdd1HourSittingTime);
    on<SittingTimesDeleted>(_onSittingTimesDeleted);
    on<AccordionStateChanged>(_onAccordionStateChanged);
  }

  /*bool _isFormValid(Emitter<AddSittingTimesState> emit) {
    bool isValid = true;

    if (state.name.isEmpty) {
      emit(state.copyWith(nameError: "Il nome è obbligatorio"));
      isValid = false;
    } else if (state.name.length > 100) {
      emit(state.copyWith(
          nameError: "Il nome non può contenere più di 100 caratteri"));
      isValid = false;
    }

    if (state.description.isEmpty) {
      emit(state.copyWith(descriptionError: "La descrizione è obbligatoria"));
      isValid = false;
    } else if (state.name.length > 100) {
      emit(state.copyWith(
          nameError: "Il nome non può contenere più di 100 caratteri"));
      isValid = false;
    }

    return isValid;
  }*/

  void _onFormSubmit(FormSubmit event, Emitter<AddSittingTimesState> emit) {
    //if (_isFormValid(emit)) {
    _navigationService.resetToScreen(homeRoute);
    //}
  }

  void _onClearSittingTimes(
      ClearSittingTimes event, Emitter<AddSittingTimesState> emit) {
    emit(state.copyWith(sittingTimes: []));
  }

  void _addSittingTimeAtTheEnd(Emitter<AddSittingTimesState> emit,
      {required int intervalInMinutes}) {
    final lastSittingTime = state.sittingTimes.lastOrNull;
    final DateTime lastEndTime;

    if (lastSittingTime == null) {
      lastEndTime = DateTime.now().copyWith(hour: 0, minute: 0);
    } else {
      lastEndTime = lastSittingTime.end;
    }

    final endTime = lastEndTime.add(Duration(minutes: intervalInMinutes));

    if (lastEndTime.day == endTime.day) {
      emit(state.copyWith(
        sittingTimes: List.of(state.sittingTimes)
          ..add(SittingTime(start: lastEndTime, end: endTime)),
      ));
    }
  }

  void _onAdd30MinutesSittingTime(
      Add30MinutesSittingTime event, Emitter<AddSittingTimesState> emit) {
    _addSittingTimeAtTheEnd(emit, intervalInMinutes: 30);
  }

  void _onAdd1HourSittingTime(
      Add1HourSittingTime event, Emitter<AddSittingTimesState> emit) {
    _addSittingTimeAtTheEnd(emit, intervalInMinutes: 60);
  }

  void _onCustomSittingTimeAdded(
      CustomSittingTimeAdded event, Emitter<AddSittingTimesState> emit) {
    bool canAdd = state.sittingTimes.isEmpty;
    int i;

    for (i = 0; i < state.sittingTimes.length; i++) {
      final current = state.sittingTimes[i];
      final next =
          i == state.sittingTimes.length - 1 ? null : state.sittingTimes[i + 1];

      if (next == null) {
        final endTime = current.start.add(const Duration(minutes: 15));

        if (event.startTime.isAfter(current.end) &&
            endTime.day == current.start.day) {
          canAdd = true;
          break;
        }
      } else {
        if (event.endTime.difference(event.startTime).inMinutes <=
            next.start.difference(current.end).inMinutes) {
          canAdd = true;
          break;
        }
      }
    }

    if (canAdd) {
      emit(state.copyWith(
        sittingTimes: List.of(state.sittingTimes)
          ..insert(state.sittingTimes.isEmpty ? 0 : i + 1,
              SittingTime(start: event.startTime, end: event.endTime)),
      ));
    }
  }

  void _onSittingTimesDeleted(
      SittingTimesDeleted event, Emitter<AddSittingTimesState> emit) {
    emit(state.copyWith(
      sittingTimes: List.of(state.sittingTimes)
        ..removeWhere((sittingTime) => sittingTime == event.sittingTime),
    ));
  }

  void _onAccordionStateChanged(
      AccordionStateChanged event, Emitter<AddSittingTimesState> emit) {
    /*final accordionState = Map.of(state.accordionsState);
    accordionState[event.weekDay] = event.state;*/

    emit(state.copyWith(accordionsState: event.state));
  }
}
