import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:foody_app/bloc/foody/foody_bloc.dart';
import 'package:foody_app/bloc/foody/foody_state.dart';
import 'package:foody_app/routing/navigation_service.dart';
import 'package:foody_app/routing/router.dart';
import 'package:foody_app/theme/theme.dart';
import 'package:foody_app/theme/util.dart';
import 'package:foody_app/widgets/foody_loader_overlay.dart';

class Foody extends StatelessWidget {
  const Foody({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme =
        MaterialTheme(createTextTheme(context, "Roboto", "Roboto"));
    return BlocBuilder<FoodyBloc, FoodyState>(
      builder: (context, state) {
        return Portal(
          child: MaterialApp(
            title: 'Foody',
            theme: state.darkTheme ? theme.dark() : theme.light(),
            onGenerateRoute: Router.generateRoute,
            initialRoute: state.initialRoute,
            navigatorKey: NavigationService().navigatorKey,
            builder: (context, child) => PortalTarget(
              portalFollower:
                  FoodyLoaderOverlay(isLoading: state.showLoadingOverlay),
              child: child!,
            ),
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            supportedLocales: const [Locale('it')],
          ),
        );
      },
    );
  }
}
