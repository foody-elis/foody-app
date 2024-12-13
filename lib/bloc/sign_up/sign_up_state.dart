import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/user_response_dto.dart';
import 'package:intl/intl.dart';

class SignUpState extends Equatable {
  final String name;
  final String surname;
  final String email;
  final String password;
  final String confirmPassword;
  final String birthDate;
  final String phoneNumber;
  final String avatar;
  final String? nameError;
  final String? surnameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? phoneNumberError;
  final String? birthDateError;
  final int activeIndex;
  final String apiError;
  final bool isLoading;

  const SignUpState({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.birthDate,
    required this.phoneNumber,
    required this.avatar,
    required this.nameError,
    required this.surnameError,
    required this.emailError,
    required this.passwordError,
    required this.confirmPasswordError,
    required this.phoneNumberError,
    required this.birthDateError,
    required this.activeIndex,
    required this.apiError,
    required this.isLoading,
  });

  SignUpState.initial(UserResponseDto? user)
      : name = user?.name ?? "",
        surname = user?.surname ?? "",
        email = user?.email ?? "",
        password = "",
        confirmPassword = "",
        birthDate = user == null ? "" : DateFormat('dd/MM/yyyy').format(user.birthDate),
        phoneNumber = user?.phoneNumber ?? "",
        avatar = user?.avatarUrl ?? "",
        nameError = null,
        surnameError = null,
        emailError = null,
        passwordError = null,
        confirmPasswordError = null,
        phoneNumberError = null,
        birthDateError = null,
        activeIndex = 0,
        isLoading = false,
        apiError = "";

  SignUpState copyWith({
    String? name,
    String? surname,
    String? email,
    String? password,
    String? confirmPassword,
    String? birthDate,
    String? phoneNumber,
    String? avatar,
    String? nameError,
    String? surnameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? phoneNumberError,
    String? birthDateError,
    int? activeIndex,
    String? apiError,
    bool? isLoading,
  }) {
    return SignUpState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      birthDate: birthDate ?? this.birthDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      nameError: nameError == "null" ? null : nameError ?? this.nameError,
      surnameError:
          surnameError == "null" ? null : surnameError ?? this.surnameError,
      emailError: emailError == "null" ? null : emailError ?? this.emailError,
      passwordError:
          passwordError == "null" ? null : passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError == "null"
          ? null
          : confirmPasswordError ?? this.confirmPasswordError,
      phoneNumberError: phoneNumberError == "null"
          ? null
          : phoneNumberError ?? this.phoneNumberError,
      birthDateError: birthDateError == "null"
          ? null
          : birthDateError ?? this.birthDateError,
      activeIndex: activeIndex ?? this.activeIndex,
      apiError: apiError ?? this.apiError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        name,
        surname,
        email,
        password,
        confirmPassword,
        birthDate,
        phoneNumber,
        avatar,
        nameError,
        surnameError,
        emailError,
        passwordError,
        confirmPasswordError,
        phoneNumberError,
        birthDateError,
        activeIndex,
        apiError,
        isLoading,
      ];
}
