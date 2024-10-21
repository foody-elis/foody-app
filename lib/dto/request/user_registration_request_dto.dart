import 'package:json_annotation/json_annotation.dart';

part '../mapper/request/user_registration_request_dto.g.dart';

@JsonSerializable()
class UserRegistrationRequestDto {
  const UserRegistrationRequestDto({
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.phoneNumber,
    required this.avatar,
  });

  factory UserRegistrationRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationRequestDtoFromJson(json);

  final String email;
  final String password;
  final String name;
  final String surname;
  final DateTime birthDate;
  final String phoneNumber;
  final String avatar;

  Map<String, dynamic> toJson() => _$UserRegistrationRequestDtoToJson(this);
}
