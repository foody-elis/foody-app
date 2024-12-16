import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'welcome_event.dart';
import 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const WelcomeState.initial()) {
    on<LoadWelcomeLottie>(_onLoadWelcomeLottie);

    add(LoadWelcomeLottie());
  }

  void _onLoadWelcomeLottie(
      LoadWelcomeLottie event, Emitter<WelcomeState> emit) async {
    final composition = await AssetLottie("assets/lottie/welcome_2.json").load();
    emit(state.copyWith(composition: composition));
  }
}
