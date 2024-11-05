import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class FetchUser extends AuthEvent {}
class FetchUserRestaurant extends AuthEvent {}

