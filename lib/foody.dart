import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/foody/foody_bloc.dart';
import 'package:foody_app/bloc/foody/foody_state.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:foody_app/routing/router.dart';
import 'package:foody_app/theme/theme.dart';
import 'package:foody_app/theme/util.dart';

class Foody extends StatelessWidget {
  const Foody({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme(createTextTheme(context, "Roboto", "Roboto"));

    return BlocBuilder<FoodyBloc, FoodyState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Foody',
          theme: state.darkTheme ? theme.dark() : theme.light(),
          onGenerateRoute: Router.generateRoute,
          initialRoute: state.initialRoute,
          navigatorKey: NavigationService().navigatorKey,
        );
      },
    );
  }
}