import 'package:equatable/equatable.dart';

class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpConsumer extends SignUpEvent {}

class SignUpRestaurateur extends SignUpEvent {}

class NameChanged extends SignUpEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class SurnameChanged extends SignUpEvent {
  const SurnameChanged({required this.surname});

  final String surname;

  @override
  List<Object> get props => [surname];
}

class EmailChanged extends SignUpEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignUpEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends SignUpEvent {
  const ConfirmPasswordChanged({required this.confirmPassword});

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class BirthDateChanged extends SignUpEvent {
  const BirthDateChanged({required this.birthDate});

  final String birthDate;

  @override
  List<Object> get props => [birthDate];
}

class ActiveIndexChanged extends SignUpEvent {
  const ActiveIndexChanged({required this.activeIndex});

  final int activeIndex;

  @override
  List<Object> get props => [activeIndex];
}

class PhoneNumberChanged extends SignUpEvent {
  const PhoneNumberChanged({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}
