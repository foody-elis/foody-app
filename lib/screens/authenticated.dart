import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_api_client/foody_api_client.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/auth/auth_state.dart';
import 'package:foody_app/bloc/bookings/bookings_bloc.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_bloc.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/screens/bookings/bookings.dart';
import 'package:foody_app/screens/profile.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_details.dart';
import 'package:foody_app/widgets/utils/show_foody_snackbar.dart';

import '../bloc/home/home_bloc.dart';
import '../widgets/foody_page_view.dart';
import 'chats/chats.dart';
import 'home/home.dart';

class Authenticated extends HookWidget {
  const Authenticated({super.key});

  @override
  Widget build(BuildContext context) {
    final avatarPrecached = useState(false);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showFoodySnackBar(context: context, msg: state.apiError);
        }

        if (!avatarPrecached.value &&
            state.userResponseDto != null &&
            state.userResponseDto!.avatarUrl != null) {
          precacheImage(
            NetworkImage(state.userResponseDto!.avatarUrl!),
            context,
          );

          avatarPrecached.value = true;
        }
      },
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            state.isRestaurateur
                ? BlocProvider<RestaurantDetailsBloc>(
                    create: (context) => RestaurantDetailsBloc(
                      foodyApiClient: context.read<FoodyApiClient>(),
                      userRepository: context.read<UserRepository>(),
                    ),
                  )
                : BlocProvider<HomeBloc>(
                    create: (context) => HomeBloc(
                      foodyApiClient: context.read<FoodyApiClient>(),
                    ),
                  ),
            BlocProvider<BookingsBloc>(
              create: (context) => BookingsBloc(
                foodyApiClient: context.read<FoodyApiClient>(),
                userRepository: context.read<UserRepository>(),
              ),
            ),
          ],
          child: FoodyPageView(
            home:
                state.isRestaurateur ? const RestaurantDetails() : const Home(),
            chats: const Chats(),
            orders: const Bookings(),
            profile: const Profile(),
          ),
        );
      },
    );
  }
}
