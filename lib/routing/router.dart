import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/booking_form/booking_form_bloc.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:foody_app/bloc/chat/chat_bloc.dart';
import 'package:foody_app/bloc/menu/menu_bloc.dart';
import 'package:foody_app/bloc/order_form/order_form_bloc.dart';
import 'package:foody_app/bloc/orders/orders_bloc.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_bloc.dart';
import 'package:foody_app/bloc/restaurant_form/restaurant_form_bloc.dart';
import 'package:foody_app/bloc/reviews/reviews_bloc.dart';
import 'package:foody_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/screens/authenticated.dart';
import 'package:foody_app/screens/booking_completed.dart';
import 'package:foody_app/screens/booking_form/booking_form.dart';
import 'package:foody_app/screens/chats/chat.dart';
import 'package:foody_app/screens/edit_profile.dart';
import 'package:foody_app/screens/info.dart';
import 'package:foody_app/screens/menu/menu.dart';
import 'package:foody_app/screens/order_form/order_form.dart';
import 'package:foody_app/screens/order_paid.dart';
import 'package:foody_app/screens/orders/orders.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_details.dart';
import 'package:foody_app/screens/restaurant_form.dart';
import 'package:foody_app/screens/reviews/reviews.dart';

import '../bloc/sitting_times_form_list/sitting_times_form_list_bloc.dart';
import '../screens/sitting_times_form/sitting_times_form_list.dart';
import '../screens/welcome/welcome.dart';
import 'constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    return switch (settings.name) {
      welcomeRoute => CupertinoPageRoute(builder: (_) => const Welcome()),
      restaurantFormRoute => CupertinoPageRoute(
          builder: (_) => BlocProvider<RestaurantFormBloc>(
            create: (context) => RestaurantFormBloc(
              foodyApiClient: context.read<FoodyApiClient>(),
              userRepository: context.read<UserRepository>(),
              restaurant: arguments?["restaurant"],
            ),
            child: const RestaurantForm(),
          ),
        ),
      sittingTimesFormRoute => CupertinoPageRoute(
          builder: (_) => BlocProvider<SittingTimesFormListBloc>(
            create: (context) => SittingTimesFormListBloc(
              foodyApiClient: context.read<FoodyApiClient>(),
              userRepository: context.read<UserRepository>(),
              isEditing: arguments?["isEditing"] ?? false,
            ),
            child: const SittingTimesFormList(),
          ),
        ),
      authenticatedRoute => CupertinoPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<BottomNavBarBloc>(
                create: (context) => BottomNavBarBloc(),
              ),
              BlocProvider<AuthBloc>(
                create: (context) => AuthBloc(
                  foodyApiClient: context.read<FoodyApiClient>(),
                  userRepository: context.read<UserRepository>(),
                ),
              ),
            ],
            child: const Authenticated(),
          ),
        ),
      restaurantDetailsRoute => CupertinoPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: arguments!["authBloc"] as AuthBloc),
              BlocProvider<RestaurantDetailsBloc>(
                create: (context) => RestaurantDetailsBloc(
                  foodyApiClient: context.read<FoodyApiClient>(),
                  userRepository: context.read<UserRepository>(),
                  restaurantId: arguments["restaurantId"],
                ),
              ),
            ],
            child: const Scaffold(
              extendBody: true,
              body: RestaurantDetails(),
            ),
          ),
        ),
      menuRoute => CupertinoPageRoute(
          builder: (_) => BlocProvider<MenuBloc>(
            create: (context) => MenuBloc(
              foodyApiClient: context.read<FoodyApiClient>(),
              restaurantId: arguments!["restaurantId"],
              canEdit: arguments["canEdit"],
            ),
            child: const Menu(),
          ),
        ),
      infoRoute => CupertinoPageRoute(
          builder: (_) => const Info(),
        ),
      editProfileRoute => CupertinoPageRoute(
          builder: (_) => BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(
              foodyApiClient: context.read<FoodyApiClient>(),
              userRepository: context.read<UserRepository>(),
              user: arguments!["user"],
              authBloc: arguments["authBloc"],
            ),
            child: const EditProfile(),
          ),
        ),
      bookingFormRoute => CupertinoPageRoute(
          builder: (_) => BlocProvider<BookingFormBloc>(
            create: (context) => BookingFormBloc(
              foodyApiClient: context.read<FoodyApiClient>(),
              restaurant: arguments!["restaurant"],
              sittingTime: arguments["sittingTime"],
            ),
            child: const BookingForm(),
          ),
        ),
      bookingCompletedRoute => CupertinoPageRoute(
          builder: (_) => BookingCompleted(booking: arguments!["booking"]),
        ),
      reviewsRoute => CupertinoPageRoute(
          builder: (_) => BlocProvider<ReviewsBloc>(
            create: (context) => ReviewsBloc(
              foodyApiClient: context.read<FoodyApiClient>(),
              restaurantId: arguments!["restaurantId"],
            ),
            child: const Reviews(),
          ),
        ),
      orderFormRoute => CupertinoPageRoute(
          builder: (_) => BlocProvider<OrderFormBloc>(
            create: (context) => OrderFormBloc(
              foodyApiClient: context.read<FoodyApiClient>(),
              restaurant: arguments!["restaurant"],
            ),
            child: const OrderForm(),
          ),
        ),
      orderPaidRoute => CupertinoPageRoute(
          builder: (_) => OrderPaid(order: arguments!["order"]),
        ),
      chatRoute => CupertinoPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: arguments!["authBloc"] as AuthBloc),
              BlocProvider<ChatBloc>(
                create: (context) => ChatBloc(
                  userRepository: context.read<UserRepository>(),
                  room: arguments["room"],
                ),
              ),
            ],
            child: const Chat(),
          ),
        ),
      ordersRoute => CupertinoPageRoute(
          builder: (_) => BlocProvider<OrdersBloc>(
            create: (context) => OrdersBloc(
              foodyApiClient: context.read<FoodyApiClient>(),
              userRepository: context.read<UserRepository>(),
            ),
            child: const Orders(),
          ),
        ),
      _ => CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        ),
    };
  }
}
