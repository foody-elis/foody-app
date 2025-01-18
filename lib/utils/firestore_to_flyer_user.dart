import 'package:flutter_chat_types/flutter_chat_types.dart';

User firestoreToFlyerUser(firebaseUser) {
  final data = firebaseUser.data()!;

  data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
  data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;
  data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;

  data["id"] = firebaseUser.id;

  return User.fromJson(data);
}
