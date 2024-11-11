import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/dto/request/user_registration_request_dto.dart';
import 'package:foody_app/dto/response/auth_response_dto.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../models/user.dart';
import '../../routing/navigation_service.dart';
import '../../utils/call_api.dart';
import '../../utils/get_foody_dio.dart';
import '../../utils/token_inteceptor.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final NavigationService _navigationService = NavigationService();
  final FoodyApiRepository foodyApiRepository;
  final UserRepository userRepository;

  SignUpBloc({required this.foodyApiRepository, required this.userRepository})
      : super(const SignUpState.initial()) {
    on<SignUpConsumer>(_onSignUpConsumer, transformer: droppable());
    on<SignUpRestaurateur>(_onSignUpRestaurateur, transformer: droppable());
    on<NameChanged>(_onNameChanged);
    on<SurnameChanged>(_onSurnameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<BirthDateChanged>(_onBirthDateChanged);
    on<ActiveIndexChanged>(_onActiveIndexChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
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

    if (state.surname.isEmpty) {
      emit(state.copyWith(surnameError: "Il cognome è obbligatorio"));
      isValid = false;
    } else if (state.surname.length > 30) {
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
    } else if (state.password.length < 8) {
      emit(state.copyWith(
          passwordError: "La password deve essere almeno di 8 caratteri"));
      isValid = false;
    } else if (state.password.length > 100) {
      emit(state.copyWith(
          passwordError:
              "La password non può essere più lunga di 100 caratteri"));
      isValid = false;
    }

    if (state.confirmPassword != state.password) {
      emit(state.copyWith(confirmPasswordError: "Le password non sono uguali"));
      isValid = false;
    }

    if (state.phoneNumber.isEmpty) {
      emit(state.copyWith(phoneNumberError: "Il cellulare è obbligatorio"));
      isValid = false;
    }

    if (state.birthDate.isEmpty) {
      emit(state.copyWith(birthDateError: "La data di nascita è obbligatoria"));
      isValid = false;
    }

    return isValid;
  }

  Future<void> _signUp({
    required Emitter<SignUpState> emit,
    required Function api,
    required void Function() onComplete,
  }) async {
    foodyApiRepository.dio = getFoodyDio(); // reset dio in case of 498

    await callApi<AuthResponseDto>(
      api: api,
      data: UserRegistrationRequestDto(
        name: state.name,
        surname: state.surname,
        email: state.email,
        password: state.password,
        phoneNumber: state.phoneNumber,
        birthDate: DateFormat("dd/MM/yyyy").parse(state.birthDate),
        avatar: "avatar.png",
      ),
      onComplete: (response) {
        userRepository.add(User(
          jwt: response.accessToken,
          role: JwtDecoder.decode(response.accessToken)["role"],
        ));
        foodyApiRepository.dio = getFoodyDio(
            tokenInterceptor: TokenInterceptor(
          token: response.accessToken,
          userRepository: userRepository,
        ));
        emit(state.copyWith(apiError: "Registazione effettuata con successo"));
        onComplete();
      },
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );
  }

  void _onSignUpConsumer(
      SignUpConsumer event, Emitter<SignUpState> emit) async {
    if (_isFormValid(emit)) {
      await _signUp(
        emit: emit,
        api: foodyApiRepository.auth.registerCustomer,
        onComplete: () => _navigationService.resetToScreen(authenticatedRoute),
      );
    }
  }

  void _onSignUpRestaurateur(
      SignUpRestaurateur event, Emitter<SignUpState> emit) async {
    if (_isFormValid(emit)) {
      await _signUp(
        emit: emit,
        api: foodyApiRepository.auth.registerRestaurateur,
        onComplete: () => _navigationService.navigateTo(addRestaurantRoute),
      );
    }
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
    emit(state.copyWith(birthDate: event.birthDate, birthDateError: "null"));
  }

  void _onActiveIndexChanged(
      ActiveIndexChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(activeIndex: event.activeIndex));
  }

  void _onPhoneNumberChanged(
      PhoneNumberChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
        phoneNumber: event.phoneNumber, phoneNumberError: "null"));
  }
}
