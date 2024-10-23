import 'package:json_annotation/json_annotation.dart';

import '../error_dto.dart';

part '../mapper/response/user_login_response_dto.g.dart';

@JsonSerializable()
class UserLoginResponseDto extends ErrorDto {
  const UserLoginResponseDto({
    required this.accessToken,
    required super.timestamp,
    required super.status,
    required super.path,
    required super.error,
    required super.message,
  });

  factory UserLoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseDtoFromJson(json);

  final String accessToken;

  @override
  Map<String, dynamic> toJson() => _$UserLoginResponseDtoToJson(this);
}
