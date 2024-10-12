import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/sitting_time.dart';

class AddSittingTimesState extends Equatable {
  final List<SittingTime> sittingTimes;
  final bool? accordionsState;

  const AddSittingTimesState({
    required this.sittingTimes,
    required this.accordionsState,
  });

  AddSittingTimesState.initial(bool defaultIntervals)
      : sittingTimes = defaultIntervals
            ? (() {
                final defaultTime = DateTime.now().copyWith(hour: 12, minute: 0);

                return List.generate(9, (int i) {
                  final start = defaultTime.add(Duration(minutes: 30 * i));
                  final end = start.add(const Duration(minutes: 30));

                  return SittingTime(start: start, end: end);
                });
              })()
            : [],
        accordionsState = null;

  AddSittingTimesState copyWith({
    List<SittingTime>? sittingTimes,
    bool? accordionsState,
  }) {
    return AddSittingTimesState(
      sittingTimes: sittingTimes ?? this.sittingTimes,
      accordionsState: accordionsState ?? this.accordionsState,
    );
  }

  @override
  List<Object?> get props => [sittingTimes, accordionsState];
}
