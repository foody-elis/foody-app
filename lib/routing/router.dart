import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/add_restaurant/add_restaurant_bloc.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:foody_app/bloc/welcome/welcome_bloc.dart';
import 'package:foody_app/screens/add_restaurant.dart';
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
            create: (context) => AddRestaurantBloc(),
            child: const AddRestaurant(),
          ),
        );
      case homeRoute:
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<BottomNavBarBloc>(
            create: (context) => BottomNavBarBloc(),
            child: const FoodyPageView(
              home: Home(),
              chats: Chats(),
              orders: Orders(),
              profile: Profile(),
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
