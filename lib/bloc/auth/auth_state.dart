import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/user_response_dto.dart';

class AuthState extends Equatable {
  final UserResponseDto? userResponseDto;
  final String apiError;
  final bool isRestaurateur;

  const AuthState({
    required this.userResponseDto,
    required this.apiError,
    required this.isRestaurateur,
  });

  const AuthState.initial(this.isRestaurateur)
      : userResponseDto = null,
        apiError = "";

  AuthState copyWith({
    UserResponseDto? userResponseDto,
    String? apiError,
  }) {
    return AuthState(
      userResponseDto: userResponseDto ?? this.userResponseDto,
      apiError: apiError ?? this.apiError,
      isRestaurateur: isRestaurateur,
    );
  }

  @override
  List<Object?> get props => [
        userResponseDto,
        apiError,
      ];
}
