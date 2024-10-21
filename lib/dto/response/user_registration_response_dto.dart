import 'package:json_annotation/json_annotation.dart';

import '../error_dto.dart';

part '../mapper/response/user_registration_response_dto.g.dart';

@JsonSerializable()
class UserRegistrationResponseDto extends ErrorDto {
  const UserRegistrationResponseDto({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.phoneNumber,
    required this.avatar,
    required this.role,
    required this.active,
    this.creditCardId,
    super.errors,
  });

  factory UserRegistrationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationResponseDtoFromJson(json);

  final int id;
  final String email;
  final String password;
  final String name;
  final String surname;
  final DateTime birthDate;
  final String phoneNumber;
  final String avatar;
  final String role;
  final bool active;
  final int? creditCardId;

  Map<String, dynamic> toJson() => _$UserRegistrationResponseDtoToJson(this);
}
