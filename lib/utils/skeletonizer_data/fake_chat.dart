import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:foody_app/widgets/foody_chat_item.dart';

FoodyChatItem getFakeChat() => const FoodyChatItem(
      room: Room(
        id: "",
        type: RoomType.direct,
        users: [
          User(id: ""),
          User(id: ""),
        ],
        lastMessages: [
          TextMessage(
            id: "",
            author: User(id: ""),
            text: 'message example',
            createdAt: 0,
          )
        ],
      ),
    );
