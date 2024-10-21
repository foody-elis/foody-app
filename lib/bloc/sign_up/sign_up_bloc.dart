import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/dto/request/user_registration_request_dto.dart';
import 'package:foody_app/dto/response/user_registration_response_dto.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';
import 'package:foody_app/routing/constants.dart';

import '../../routing/navigation_service.dart';
import '../../utils/call_api.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final NavigationService _navigationService = NavigationService();
  final FoodyApiRepository foodyApiRepository;

  SignUpBloc({required this.foodyApiRepository}) : super(const SignUpState.initial()) {
    on<SignUpConsumer>(_onSignUpConsumer, transformer: droppable());
    on<SignUpRestaurateur>(_onSignUpRestaurateur, transformer: droppable());
    on<NameChanged>(_onNameChanged);
    on<SurnameChanged>(_onSurnameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<BirthDateChanged>(_onBirthDateChanged);
    on<ActiveIndexChanged>(_onActiveIndexChanged);
  }

  bool _isFormValid(Emitter<SignUpState> emit) {
    bool isValid = true;

    if (state.name.isEmpty) {
      emit(state.copyWith(nameError: "Il nome è obbligatorio"));
      isValid = false;
    } else if (state.name.length > 30) {
      emit(state.copyWith(
          nameError: "Il nome non può contenere più di 30 caratteri"));
      isValid = false;
    }

    if (state.surname.length > 30) {
      emit(state.copyWith(
          surnameError: "Il cognome non può contenere più di 30 caratteri"));
      isValid = false;
    }

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
    }

    if (state.confirmPassword != state.password) {
      emit(state.copyWith(
          confirmPasswordError:
              "Le password non coincidono"));
      isValid = false;
    }

    return isValid;
  }

  void _onSignUpConsumer(SignUpConsumer event, Emitter<SignUpState> emit) async {
    //if (_isFormValid(emit)) {
    //   _navigationService.replaceScreen(homeRoute);
    //}

    await callApi<UserRegistrationResponseDto>(
      api: foodyApiRepository.auth.registerCustomer,
      data: UserRegistrationRequestDto(
        name: "aa",
        surname: "bb",
        email: "cc@gmail.com",
        password: "dd",
        phoneNumber: "",
        // birthDate: DateTime.parse(state.birthDate),
        birthDate: DateTime.now(),
        avatar: " ",
      ),
      onComplete: (response) => print(response),
      onFailed: (errors, statusCode) {
        for (String error in errors) {
          emit(state.copyWith(apiError: error));
        }

        emit(state.copyWith(apiError: ""));
      },
      onError: () {
        emit(state.copyWith(
          apiError: "There was an error while logging in. Try again in a while.",
        ));
        emit(state.copyWith(apiError: ""));
      },
    );
  }

  void _onSignUpRestaurateur(
      SignUpRestaurateur event, Emitter<SignUpState> emit) {
    //if (_isFormValid(emit)) {
      _navigationService.navigateTo(addRestaurant);
   // }
  }

  void _onNameChanged(NameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(name: event.name, nameError: "null"));
  }

  void _onSurnameChanged(SurnameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(surname: event.surname, surnameError: "null"));
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: event.email, emailError: "null"));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: event.password, passwordError: "null"));
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
        confirmPassword: event.confirmPassword, confirmPasswordError: "null"));
  }

  void _onBirthDateChanged(BirthDateChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(birthDate: event.birthDate));
  }

  void _onActiveIndexChanged(
      ActiveIndexChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(activeIndex: event.activeIndex));
  }
}
