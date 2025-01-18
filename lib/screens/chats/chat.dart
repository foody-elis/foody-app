import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/chat/chat_bloc.dart';
import 'package:foody_app/bloc/chat/chat_event.dart';
import "package:foody_app/bloc/chat/chat_state.dart";
import 'package:foody_app/hooks/foody_widgets_binding_observer.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:foody_app/utils/show_foody_image_picker.dart';
import 'package:foody_app/widgets/foody_chat.dart';
import 'package:foody_app/widgets/foody_circular_image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/auth/auth_event.dart';

class Chat extends HookWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    useFoodyOnAppLifecycleStateChange(
      /*onStateChanged: (previous, current) {
        print("previous: $previous");
        print("current: $current");
      },*/
      onDeactivate: () {
        context.read<AuthBloc>().add(ClearUserFirebaseRoomId());
      },
    );

    useEffect(() {
      context.read<AuthBloc>().add(
          UpdateUserFirebaseRoomId(roomId: context.read<ChatBloc>().room.id));
      return null;
    }, []);

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: SafeArea(
                  bottom: false,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => NavigationService().goBack(),
                        icon: const Icon(
                          PhosphorIconsRegular.arrowLeft,
                          color: Colors.white,
                        ),
                      ),
                      FoodyCircularImage(
                        showShadow: false,
                        size: 35,
                        padding: 8,
                        imageUrl: state.secondaryUser.imageUrl,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${state.secondaryUser.firstName} ${state.secondaryUser.lastName}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<Message>>(
                  initialData: const [],
                  stream: FirebaseChatCore.instance
                      .messages(context.read<ChatBloc>().room),
                  builder: (context, snapshot) {
                    context.read<ChatBloc>().add(MarkAllAsSeen());

                    return FoodyChat(
                      messages: snapshot.data ?? [],
                      onSendPressed: (PartialText p) => context
                          .read<ChatBloc>()
                          .add(SendPressed(partialText: p)),
                      onFilePressed: () =>
                          context.read<ChatBloc>().add(HandleFileSelection()),
                      mainUser: state.mainUser,
                      secondaryUser: state.secondaryUser,
                      onMessageTap: (_, m) => context
                          .read<ChatBloc>()
                          .add(HandleMessageTap(message: m)),
                      onImagePressed: () => showFoodyImagePicker(
                        context: context,
                        onCameraTap: () {
                          NavigationService().goBack();
                          context.read<ChatBloc>().add(ImagePickerCamera());
                        },
                        onGalleryTap: () {
                          NavigationService().goBack();
                          context.read<ChatBloc>().add(ImagePickerGallery());
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
