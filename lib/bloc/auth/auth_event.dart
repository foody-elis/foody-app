import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class FetchUser extends AuthEvent {}

class Logout extends AuthEvent {}

class ClearUserFirebaseRoomId extends AuthEvent {}

class UpdateUserFirebaseRoomId extends AuthEvent {
  const UpdateUserFirebaseRoomId({required this.roomId});

  final String roomId;

  @override
  List<Object> get props => [roomId];
}
