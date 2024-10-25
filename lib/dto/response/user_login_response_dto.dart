import 'package:json_annotation/json_annotation.dart';

part '../mapper/response/user_login_response_dto.g.dart';

@JsonSerializable()
class UserLoginResponseDto {
  const UserLoginResponseDto({required this.accessToken});

  factory UserLoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseDtoFromJson(json);

  final String accessToken;

  Map<String, dynamic> toJson() => _$UserLoginResponseDtoToJson(this);
}
