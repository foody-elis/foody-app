import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/auth/auth_state.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_bloc.dart';
import 'package:foody_app/screens/bookings.dart';
import 'package:foody_app/screens/profile.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_details.dart';
import 'package:foody_app/utils/show_snackbar.dart';

import '../bloc/home/home_bloc.dart';
import '../repository/interface/foody_api_repository.dart';
import '../widgets/foody_page_view.dart';
import 'chats.dart';
import 'home/home.dart';
import 'orders.dart';

class Authenticated extends StatelessWidget {
  const Authenticated({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showSnackBar(context: context, msg: state.apiError);
        }
      },
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            state.isRestaurateur
                ? BlocProvider<RestaurantDetailsBloc>(
                    create: (context) => RestaurantDetailsBloc(
                      foodyApiRepository: context.read<FoodyApiRepository>(),
                    ),
                  )
                : BlocProvider<HomeBloc>(
                    create: (context) => HomeBloc(
                      foodyApiRepository: context.read<FoodyApiRepository>(),
                    ),
                  ),
          ],
          child: FoodyPageView(
            home:
                state.isRestaurateur ? const RestaurantDetails() : const Home(),
            chats: const Chats(),
            orders: state.isRestaurateur ? const Bookings() : const Orders(),
            profile: const Profile(),
          ),
        );
      },
    );
  }
}
