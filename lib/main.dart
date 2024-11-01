import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/foody/foody_bloc.dart';
import 'package:foody_app/foody.dart';
import 'package:foody_app/repository/impl/settings_repository_impl.dart';
import 'package:foody_app/repository/impl/user_repository_impl.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';
import 'package:foody_app/repository/interface/settings_repository.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/utils/get_foody_dio.dart';

import 'object_box/objectbox.dart';

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectBox = await ObjectBox.create();

  final userRepository = UserRepositoryImpl();
  // userRepository.removeAll();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => userRepository,
        ),
        RepositoryProvider<SettingsRepository>(
          create: (_) => SettingsRepositoryImpl(),
        ),
        RepositoryProvider<FoodyApiRepository>(
          create: (_) => FoodyApiRepository(
            dio: getFoodyDio(token: userRepository.get()?.jwt),
          ),
        ),
      ],
      child: BlocProvider<FoodyBloc>(
        create: (context) => FoodyBloc(),
        child: const Foody(),
      ),
    ),
  );
}
