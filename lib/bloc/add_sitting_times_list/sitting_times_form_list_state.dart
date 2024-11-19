import 'package:equatable/equatable.dart';
import 'package:foody_app/bloc/add_sitting_times_list/sitting_times_form_state.dart';

class SittingTimesFormListState extends Equatable {
  final Map<String, SittingTimesFormState> weekDays;
  final String error;
  final bool isFetchingWeekdays;

  const SittingTimesFormListState({
    required this.weekDays,
    required this.error,
    required this.isFetchingWeekdays,
  });

  SittingTimesFormListState.initial()
      : weekDays = {
          "Lunedì": const SittingTimesFormState.initial(),
          "Martedì": const SittingTimesFormState.initial(),
          "Mercoledì": const SittingTimesFormState.initial(),
          "Giovedì": const SittingTimesFormState.initial(),
          "Venerdì": const SittingTimesFormState.initial(),
          "Sabato": const SittingTimesFormState.initial(),
          "Domenica": const SittingTimesFormState.initial()
        },
        error = "",
        isFetchingWeekdays = false;

  SittingTimesFormListState copyWith({
    Map<String, SittingTimesFormState>? weekDays,
    String? error,
    bool? isFetchingWeekdays,
  }) {
    return SittingTimesFormListState(
      weekDays: weekDays ?? this.weekDays,
      error: error ?? this.error,
      isFetchingWeekdays: isFetchingWeekdays ?? this.isFetchingWeekdays,
    );
  }

  @override
  List<Object?> get props => [weekDays, error, isFetchingWeekdays];
}
