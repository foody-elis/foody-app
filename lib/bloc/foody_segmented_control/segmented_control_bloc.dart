import 'package:flutter_bloc/flutter_bloc.dart';

import 'segmented_control_event.dart';
import 'segmented_control_state.dart';

class SegmentedControlBloc extends Bloc<SegmentedControlEvent, SegmentedControlState> {
  SegmentedControlBloc() : super(const SegmentedControlState.initial()) {
    on<ActiveIndexChanged>(_onActiveIndexChanged);
  }

  void _onActiveIndexChanged(
      ActiveIndexChanged event, Emitter<SegmentedControlState> emit) {
    emit(state.copyWith(activeIndex: event.activeIndex));
  }
}
