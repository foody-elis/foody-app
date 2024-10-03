import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_bar_event.dart';
import 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc() : super(const BottomNavBarState.initial()) {
    on<IndexChanged>(_onIndexChanged);
    on<CanShowChanged>(_onCanShowChanged);
  }

  void _onIndexChanged(IndexChanged event, Emitter<BottomNavBarState> emit) {
    emit(state.copyWith(index: event.index));
  }

  void _onCanShowChanged(CanShowChanged event, Emitter<BottomNavBarState> emit) {
    emit(state.copyWith(canShow: event.canShow));
  }
}
