import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String name;
  final String surname;
  final String email;
  final String password;
  final String confirmPassword;
  final String birthDate;
  final String? nameError;
  final String? surnameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final int activeIndex;
  final String apiError;

  const SignUpState({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.birthDate,
    required this.nameError,
    required this.surnameError,
    required this.emailError,
    required this.passwordError,
    required this.confirmPasswordError,
    required this.activeIndex,
    required this.apiError,
  });

  const SignUpState.initial()
      : name = "",
        surname = "",
        email = "",
        password = "",
        confirmPassword = "",
        birthDate = "",
        nameError = null,
        surnameError = null,
        emailError = null,
        passwordError = null,
        confirmPasswordError = null,
        activeIndex = 0,
        apiError = "";

  SignUpState copyWith({
    String? name,
    String? surname,
    String? email,
    String? password,
    String? confirmPassword,
    String? birthDate,
    String? nameError,
    String? surnameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    int? activeIndex,
    String? apiError,
  }) {
    return SignUpState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      birthDate: birthDate ?? this.birthDate,
      nameError: nameError == "null" ? null : nameError ?? this.nameError,
      surnameError:
          surnameError == "null" ? null : surnameError ?? this.surnameError,
      emailError: emailError == "null" ? null : emailError ?? this.emailError,
      passwordError:
          passwordError == "null" ? null : passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError == "null"
          ? null
          : confirmPasswordError ?? this.confirmPasswordError,
      activeIndex: activeIndex ?? this.activeIndex,
      apiError: apiError ?? this.apiError,
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
        nameError,
        surnameError,
        emailError,
        passwordError,
        confirmPasswordError,
        activeIndex,
        apiError,
      ];
}
