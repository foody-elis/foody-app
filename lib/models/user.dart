import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id = 0;

  String jwt;

  User({required this.jwt});
}
