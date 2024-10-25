import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/add_restaurant/add_restaurant_bloc.dart';
import 'package:foody_app/bloc/add_sitting_times_list/add_sitting_times_list_bloc.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:foody_app/bloc/home/home_bloc.dart';
import 'package:foody_app/bloc/welcome/welcome_bloc.dart';
import 'package:foody_app/repository/interface/foody_api_repository.dart';
import 'package:foody_app/screens/add_restaurant.dart';
import 'package:foody_app/screens/add_sitting_times/add_sitting_times.dart';
import 'package:foody_app/screens/add_sitting_times/add_sitting_times_list.dart';
import 'package:foody_app/screens/home/home.dart';

import '../screens/chats.dart';
import '../screens/orders.dart';
import '../screens/profile.dart';
import '../screens/welcome/welcome.dart';
import '../widgets/foody_page_view.dart';
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
      case addRestaurant:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<AddRestaurantBloc>(
            create: (context) => AddRestaurantBloc(
              foodyApiRepository: context.read<FoodyApiRepository>(),
            ),
            child: AddRestaurant(),
          ),
        );
      case addSittingTimes:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<AddSittingTimesListBloc>(
            create: (context) => AddSittingTimesListBloc(),
            child: const AddSittingTimesList(),
          ),
        );
      case homeRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<BottomNavBarBloc>(
            create: (context) => BottomNavBarBloc(),
            child: FoodyPageView(
              home: BlocProvider<HomeBloc>(
                create: (context) => HomeBloc(),
                child: const Home(),
              ),
              chats: const Chats(),
              orders: const Orders(),
              profile: const Profile(),
            ),
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
