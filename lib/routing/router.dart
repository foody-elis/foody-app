import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/add_restaurant/add_restaurant_bloc.dart';
import 'package:foody_app/bloc/add_sitting_times_list/add_sitting_times_list_bloc.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:foody_app/bloc/welcome/welcome_bloc.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/screens/add_restaurant.dart';
import 'package:foody_app/screens/add_sitting_times/add_sitting_times_list.dart';
import 'package:foody_app/screens/authenticated.dart';

import '../screens/welcome/welcome.dart';
import 'constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<WelcomeBloc>(
            create: (context) => WelcomeBloc(),
            child: const Welcome(),
          ),
        );
      case addRestaurantRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<AddRestaurantBloc>(
            create: (context) => AddRestaurantBloc(
              foodyApiRepository: context.read<FoodyApiRepository>(),
            ),
            child: const AddRestaurant(),
          ),
        );
      case addSittingTimesRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<AddSittingTimesListBloc>(
            create: (context) => AddSittingTimesListBloc(
              foodyApiRepository: context.read<FoodyApiRepository>(),
            ),
            child: const AddSittingTimesList(),
          ),
        );
      case authenticatedRoute:
        return CupertinoPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<BottomNavBarBloc>(
                create: (context) => BottomNavBarBloc(),
              ),
              BlocProvider<AuthBloc>(
                create: (context) => AuthBloc(
                  foodyApiRepository: context.read<FoodyApiRepository>(),
                  userRepository: context.read<UserRepository>(),
                ),
              ),
            ],
            child: const Authenticated(),
          ),
        );
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
