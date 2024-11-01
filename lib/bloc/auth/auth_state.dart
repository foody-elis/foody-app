import 'package:equatable/equatable.dart';
import 'package:foody_app/dto/response/user_response_dto.dart';

class AuthState extends Equatable {
  final UserResponseDto? userResponseDto;
  final String apiError;

  const AuthState({
    required this.userResponseDto,
    required this.apiError,
  });

  const AuthState.initial()
      : userResponseDto = null,
        apiError = "";

  AuthState copyWith({
    UserResponseDto? userResponseDto,
    String? apiError,
  }) {
    return AuthState(
      userResponseDto: userResponseDto ?? this.userResponseDto,
      apiError: apiError ?? this.apiError,
    );
  }

  @override
  List<Object?> get props => [userResponseDto, apiError];
}
