import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/bloc/auth/auth_state.dart';
import 'package:foody_app/screens/profile.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showSnackBar(context: context, msg: state.apiError);
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              foodyApiRepository: context.read<FoodyApiRepository>(),
            ),
          ),
        ],
        child: const FoodyPageView(
          home: Home(),
          chats: Chats(),
          orders: Orders(),
          profile: Profile(),
        ),
      ),
    );
  }
}
