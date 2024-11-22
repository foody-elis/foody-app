import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/interface/user_repository.dart';
import 'foody_event.dart';
import 'foody_state.dart';

class FoodyBloc extends Bloc<FoodyEvent, FoodyState> {
  final UserRepository userRepository;
  // final SettingsRepository settingsRepository;

  FoodyBloc({
    required this.userRepository,
    /*required this.settingsRepository*/
  }) : super(FoodyState.initial(
          /*settingsRepository.get(),*/
          userRepository.isLogged(),
        )) {
    on<DarkThemeToggled>(_onDarkThemeToggled);
    on<ShowLoadingOverlayChanged>(_onShowLoadingOverlayChanged);
  }

  void _onDarkThemeToggled(DarkThemeToggled event, Emitter<FoodyState> emit) {
    /*final settings = settingsRepository.get();
    settings?.darkTheme = !settings.darkTheme;
    settingsRepository.update(settings!);*/
    emit(state.copyWith(darkTheme: !state.darkTheme));
  }

  void _onShowLoadingOverlayChanged(ShowLoadingOverlayChanged event, Emitter<FoodyState> emit) {
    emit(state.copyWith(showLoadingOverlay: event.show));
  }
}
