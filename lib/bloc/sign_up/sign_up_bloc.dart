import 'dart:convert';
import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/request/user_registration_request_dto.dart';
import 'package:foody_api_client/dto/request/user_update_request_dto.dart';
import 'package:foody_api_client/dto/response/auth_response_dto.dart';
import 'package:foody_api_client/dto/response/user_response_dto.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/call_api.dart';
import 'package:foody_api_client/utils/get_foody_dio.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/auth/auth_event.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:foody_app/utils/get_token_interceptor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../models/user.dart';
import '../../routing/navigation_service.dart';
import '../../utils/download_and_save_file.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final NavigationService _navigationService = NavigationService();
  final FoodyApiClient foodyApiClient;
  final UserRepository userRepository;
  final UserResponseDto? user;
  final AuthBloc? authBloc;

  SignUpBloc({
    required this.foodyApiClient,
    required this.userRepository,
    this.user,
    this.authBloc,
  }) : super(SignUpState.initial(user)) {
    on<SignUpConsumer>(_onSignUpConsumer, transformer: droppable());
    on<SignUpRestaurateur>(_onSignUpRestaurateur, transformer: droppable());
    on<EditUser>(_onEditUser, transformer: droppable());
    on<NameChanged>(_onNameChanged);
    on<SurnameChanged>(_onSurnameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<BirthDateChanged>(_onBirthDateChanged);
    on<ActiveIndexChanged>(_onActiveIndexChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<ImagePickerGallery>(_onImagePickerGallery);
    on<ImagePickerCamera>(_onImagePickerCamera);
    on<ImagePickerRemove>(_onImagePickerRemove);
  }

  bool _isEditFormValid(Emitter<SignUpState> emit) {
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

    if (state.phoneNumber.isEmpty) {
      emit(state.copyWith(phoneNumberError: "Il cellulare è obbligatorio"));
      isValid = false;
    } else if (state.phoneNumber.length > 16) {
      emit(state.copyWith(
          phoneNumberError:
              "Il cellulare non può contenere più di 16 caratteri"));
      isValid = false;
    }

    if (state.birthDate.isEmpty) {
      emit(state.copyWith(birthDateError: "La data di nascita è obbligatoria"));
      isValid = false;
    }

    return isValid;
  }

  bool _isFormValid(Emitter<SignUpState> emit) {
    bool isValid = _isEditFormValid(emit);

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

    return isValid;
  }

  Future<void> _signUp({
    required Emitter<SignUpState> emit,
    required Function(UserRegistrationRequestDto) api,
    required void Function() onComplete,
  }) async {
    foodyApiClient.dio = getFoodyDio(); // reset dio in case of 498

    emit(state.copyWith(isLoading: true));

    await callApi<AuthResponseDto>(
      api: () => api(UserRegistrationRequestDto(
        name: state.name,
        surname: state.surname,
        email: state.email,
        password: state.password,
        phoneNumber: state.phoneNumber,
        birthDate: DateFormat("dd/MM/yyyy").parse(state.birthDate),
        avatarBase64: state.avatarPath == ""
            ? null
            : base64Encode(File(state.avatarPath).readAsBytesSync()),
      )),
      onComplete: (response) {
        userRepository.add(User(
          jwt: response.accessToken,
          role: JwtDecoder.decode(response.accessToken)["role"],
        ));
        foodyApiClient.dio = getFoodyDio(
            tokenInterceptor: getTokenInterceptor(
          token: response.accessToken,
          userRepository: userRepository,
        ));
        emit(state.copyWith(apiError: "Registazione effettuata con successo"));
        emit(state.copyWith(apiError: ""));
        onComplete();
      },
      errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
    );

    emit(state.copyWith(isLoading: false));
  }

  void _onSignUpConsumer(
      SignUpConsumer event, Emitter<SignUpState> emit) async {
    if (_isFormValid(emit)) {
      await _signUp(
        emit: emit,
        api: foodyApiClient.auth.registerCustomer,
        onComplete: () => _navigationService.resetToScreen(authenticatedRoute),
      );
    }
  }

  void _onSignUpRestaurateur(
      SignUpRestaurateur event, Emitter<SignUpState> emit) async {
    if (_isFormValid(emit)) {
      await _signUp(
        emit: emit,
        api: foodyApiClient.auth.registerRestaurateur,
        onComplete: () => _navigationService.navigateTo(restaurantFormRoute),
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

  void _onEditUser(EditUser event, Emitter<SignUpState> emit) async {
    if (_isEditFormValid(emit)) {
      emit(state.copyWith(isLoading: true));

      final avatarPath = state.avatarPath == ""
          ? state.avatarUrl == ""
              ? ""
              : await downloadAndSaveFile(state.avatarUrl, "avatar_edit")
          : state.avatarPath;

      await callApi<UserResponseDto>(
        api: () => foodyApiClient.users.edit(
          UserUpdateRequestDto(
            name: state.name,
            surname: state.surname,
            birthDate: DateFormat("dd/MM/yyyy").parse(state.birthDate),
            phoneNumber: state.phoneNumber,
            avatarBase64: avatarPath == ""
                ? null
                : base64Encode(File(avatarPath).readAsBytesSync()),
          ),
        ),
        onComplete: (response) {
          emit(state.copyWith(apiError: "Dati aggiornati con successo"));
          emit(state.copyWith(apiError: ""));
          authBloc!.add(FetchUser());
        },
        errorToEmit: (msg) => emit(state.copyWith(apiError: msg)),
      );

      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onImagePicker(
      Emitter<SignUpState> emit, ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      emit(state.copyWith(avatarPath: pickedFile.path, avatarUrl: ""));
      _navigationService.goBack();
    }
  }

  void _onImagePickerGallery(
      ImagePickerGallery event, Emitter<SignUpState> emit) async {
    await _onImagePicker(emit, ImageSource.gallery);
  }

  void _onImagePickerCamera(
      ImagePickerCamera event, Emitter<SignUpState> emit) async {
    await _onImagePicker(emit, ImageSource.camera);
  }

  void _onImagePickerRemove(
      ImagePickerRemove event, Emitter<SignUpState> emit) {
    emit(state.copyWith(avatarPath: "", avatarUrl: ""));
    _navigationService.goBack();
  }
}
