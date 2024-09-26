import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/routing/constants.dart';

import '../../routing/navigation_service.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final NavigationService _navigationService = NavigationService();

  SignInBloc() : super(const SignInState.initial()) {
    on<LoginSubmit>(_onLoginSubmit, transformer: droppable());
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  bool _isFormValid(Emitter<SignInState> emit) {
    bool isValid = true;

    if (state.email.isEmpty) {
      emit(state.copyWith(emailError: "L'email è obbligatoria"));
      isValid = false;
    } else if (!EmailValidator.validate(state.email)) {
      emit(state.copyWith(emailError: "L'email non è valida"));
      isValid = false;
    }

    if (state.password.isEmpty) {
      emit(state.copyWith(passwordError: "La password è obbligatoria"));
      isValid = false;
    }/* else if (state.password.length > 100) {
      emit(state.copyWith(
          email: "The account name cannot be longer than 256 characters"));
      isValid = false;
    }*/

    return isValid;
  }

  void _onLoginSubmit(LoginSubmit event, Emitter<SignInState> emit) {
    if (_isFormValid(emit)) {
      _navigationService.resetToScreen(homeRoute);
    }
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.email, emailError: "null"));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password, passwordError: "null"));
  }
}
