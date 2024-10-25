import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final String apiError;

  const SignInState({
    required this.email,
    required this.password,
    required this.emailError,
    required this.passwordError,
    required this.apiError,
  });

  const SignInState.initial()
      : email = "",
        password = "",
        emailError = null,
        passwordError = null,
        apiError = "";

  SignInState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    String? apiError,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError == "null" ? null : emailError ?? this.emailError,
      passwordError:
          passwordError == "null" ? null : passwordError ?? this.passwordError,
      apiError: apiError ?? this.apiError,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        emailError,
        passwordError,
        apiError,
      ];
}
