import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:foody_app/bloc/menu/menu_bloc.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_bloc.dart';
import 'package:foody_app/bloc/restaurant_form/restaurant_form_bloc.dart';
import 'package:foody_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:foody_app/bloc/welcome/welcome_bloc.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/screens/authenticated.dart';
import 'package:foody_app/screens/edit_profile.dart';
import 'package:foody_app/screens/menu/menu.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_details.dart';
import 'package:foody_app/screens/restaurant_form.dart';
import 'package:foody_app/screens/settings.dart';

import '../bloc/add_sitting_times_list/sitting_times_form_list_bloc.dart';
import '../screens/sitting_times_form/sitting_times_form_list.dart';
import '../screens/welcome/welcome.dart';
import 'constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case welcomeRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<WelcomeBloc>(
            create: (context) => WelcomeBloc(),
            child: const Welcome(),
          ),
        );
      case restaurantFormRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<RestaurantFormBloc>(
            create: (context) => RestaurantFormBloc(
              foodyApiRepository: context.read<FoodyApiRepository>(),
              userRepository: context.read<UserRepository>(),
              restaurant: arguments?["restaurant"],
            ),
            child: const RestaurantForm(),
          ),
        );
      case sittingTimesFormRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<SittingTimesFormListBloc>(
            create: (context) => SittingTimesFormListBloc(
              foodyApiRepository: context.read<FoodyApiRepository>(),
              userRepository: context.read<UserRepository>(),
              isEditing: arguments?["isEditing"] ?? false,
            ),
            child: const SittingTimesFormList(),
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
      case restaurantDetailsRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<RestaurantDetailsBloc>(
            create: (context) => RestaurantDetailsBloc(
              foodyApiRepository: context.read<FoodyApiRepository>(),
              userRepository: context.read<UserRepository>(),
              restaurantId: arguments?["restaurantId"],
            ),
            child: const Scaffold(
              extendBody: true,
              body: RestaurantDetails(),
            ),
          ),
        );
      case menuRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<MenuBloc>(
            create: (context) => MenuBloc(
              foodyApiRepository: context.read<FoodyApiRepository>(),
              restaurantId: arguments?["restaurantId"],
            ),
            child: const Menu(),
          ),
        );
      case settingsRoute:
        return CupertinoPageRoute(
          builder: (_) => const Settings(),
        );
      case editProfileRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(
              foodyApiRepository: context.read<FoodyApiRepository>(),
              userRepository: context.read<UserRepository>(),
              user: arguments!["user"],
            ),
            child: const EditProfile(),
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
