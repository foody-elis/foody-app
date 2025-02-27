import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/home/home_event.dart';
import 'package:foody_app/bloc/home/home_state.dart';
import 'package:foody_app/screens/home/categories.dart';
import 'package:foody_app/screens/home/current_bookings.dart';
import 'package:foody_app/screens/home/restaurants.dart';
import 'package:foody_app/widgets/foody_main_layout.dart';
import 'package:foody_app/widgets/utils/show_foody_snackbar.dart';

import '../../bloc/auth/auth_event.dart';
import '../../bloc/home/home_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showFoodySnackBar(context: context, msg: state.apiError);
        }
      },
      child: FoodyMainLayout(
        onRefresh: () async {
          context
              .read<HomeBloc>()
              .add(FetchCategoriesAndRestaurantsAndCurrentBookings());
          context.read<AuthBloc>().add(FetchUser());
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CurrentBookings(),
              Categories(),
              Restaurants(),
            ],
          ),
        ),
      ),
    );
  }
}
