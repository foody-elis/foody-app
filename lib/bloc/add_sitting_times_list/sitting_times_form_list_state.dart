import 'package:equatable/equatable.dart';
import 'package:foody_app/bloc/add_sitting_times_list/sitting_times_form_state.dart';

class SittingTimesFormListState extends Equatable {
  final Map<String, SittingTimesFormState> weekDays;
  final String error;
  final bool isLoading;

  const SittingTimesFormListState({
    required this.weekDays,
    required this.error,
    required this.isLoading,
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
        isLoading = false;

  SittingTimesFormListState copyWith({
    Map<String, SittingTimesFormState>? weekDays,
    String? error,
    bool? isLoading,
  }) {
    return SittingTimesFormListState(
      weekDays: weekDays ?? this.weekDays,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [weekDays, error, isLoading];
}
