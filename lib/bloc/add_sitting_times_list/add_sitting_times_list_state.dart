import 'package:equatable/equatable.dart';
import 'package:foody_app/bloc/add_sitting_times_list/add_sitting_times_state.dart';

class AddSittingTimesListState extends Equatable {
  final Map<String, AddSittingTimesState> weekDays;
  final String error;

  const AddSittingTimesListState({required this.weekDays, required this.error});

  AddSittingTimesListState.initial()
      : weekDays = {
          "Lunedì": const AddSittingTimesState.initial(),
          "Martedì": const AddSittingTimesState.initial(),
          "Mercoledì": const AddSittingTimesState.initial(),
          "Giovedì": const AddSittingTimesState.initial(),
          "Venerdì": const AddSittingTimesState.initial(),
          "Sabato": const AddSittingTimesState.initial(),
          "Domenica": const AddSittingTimesState.initial()
        },
        error = "";

  AddSittingTimesListState copyWith({
    Map<String, AddSittingTimesState>? weekDays,
    String? error,
  }) {
    return AddSittingTimesListState(
      weekDays: weekDays ?? this.weekDays,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [weekDays, error];
}
