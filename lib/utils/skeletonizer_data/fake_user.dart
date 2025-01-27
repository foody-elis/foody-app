import 'package:foody_api_client/dto/response/user_response_dto.dart';
import 'package:foody_api_client/utils/roles.dart';

UserResponseDto getFakeUser() => UserResponseDto(
      id: 0,
      email: "matteo@gmail.com",
      name: "Nome",
      surname: "Congome",
      birthDate: DateTime(2003, 09, 23),
      phoneNumber: "",
      avatarUrl: "",
      role: Role.CUSTOMER,
      active: true,
      firebaseCustomToken: null,
    );
