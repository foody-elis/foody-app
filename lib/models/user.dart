import 'package:foody_app/utils/roles.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id = 0;

  String jwt;

  String email;
  String name;
  String surname;
  DateTime birthDate;
  String? phoneNumber;
  String? avatar;
  bool active;

  @Transient()
  late Role role;
  int get dbPasswordAskTime => role.index;
  set dbPasswordAskTime(int value) => role = Role.values[value];

  User({
    required this.jwt,
    required this.email,
    required this.name,
    required this.surname,
    required this.birthDate,
    this.phoneNumber,
    this.avatar,
    required this.active,
  });
}
