import 'package:json_annotation/json_annotation.dart';

import '../../utils/datetime_json_serializer.dart';

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
  final String phoneNumber;
  final String avatar;

  @JsonKey(fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  final DateTime birthDate;

  Map<String, dynamic> toJson() => _$UserRegistrationRequestDtoToJson(this);
}


