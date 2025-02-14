import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_api_client/utils/get_foody_dio.dart';
import 'package:foody_app/bloc/foody/foody_bloc.dart';
import 'package:foody_app/foody.dart';
import 'package:foody_app/repository/impl/settings_repository_impl.dart';
import 'package:foody_app/repository/impl/user_repository_impl.dart';
import 'package:foody_app/repository/interface/settings_repository.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/utils/firebase_notification_service.dart';
import 'package:foody_app/utils/get_token_interceptor.dart';

import 'firebase_options.dart';
import 'object_box/objectbox.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectBox = await ObjectBox.create();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initFirebaseFCM();

  final userRepository = UserRepositoryImpl();
  final token = userRepository.get()?.jwt;
  final tokenInterceptor = token != null
      ? getTokenInterceptor(token: token, userRepository: userRepository)
      : null;

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => userRepository,
        ),
        RepositoryProvider<SettingsRepository>(
          create: (_) => SettingsRepositoryImpl(),
        ),
        RepositoryProvider<FoodyApiClient>(
          create: (_) => FoodyApiClient(
            dio: getFoodyDio(
              tokenInterceptor: tokenInterceptor,
            ),
          ),
        ),
      ],
      child: BlocProvider<FoodyBloc>(
        create: (context) => FoodyBloc(userRepository: userRepository),
        child: const Foody(),
      ),
    ),
  );
}
