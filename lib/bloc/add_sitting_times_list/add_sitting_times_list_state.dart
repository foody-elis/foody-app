import 'package:equatable/equatable.dart';
import 'package:foody_app/bloc/add_sitting_times_list/add_sitting_times_state.dart';

class AddSittingTimesListState extends Equatable {
  final Map<String, AddSittingTimesState> weekDays;

  const AddSittingTimesListState({required this.weekDays});

  AddSittingTimesListState.initial()
      : weekDays = {
          "Lunedì": const AddSittingTimesState.initial(),
          "Martedì": const AddSittingTimesState.initial(),
          "Mercoledì": const AddSittingTimesState.initial(),
          "Giovedì": const AddSittingTimesState.initial(),
          "Venerdì": const AddSittingTimesState.initial(),
          "Sabato": const AddSittingTimesState.initial(),
          "Domenica": const AddSittingTimesState.initial()
        };

  AddSittingTimesListState copyWith({
    Map<String, AddSittingTimesState>? weekDays,
  }) {
    return AddSittingTimesListState(weekDays: weekDays ?? this.weekDays);
  }

  @override
  List<Object?> get props => [weekDays];
}
