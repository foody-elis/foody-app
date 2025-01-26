import 'package:foody_api_client/utils/token_interceptor.dart';
import 'package:foody_app/repository/interface/user_repository.dart';
import 'package:foody_app/routing/constants.dart';
import 'package:foody_app/routing/navigation_service.dart';

TokenInterceptor getTokenInterceptor({
  required String token,
  required UserRepository userRepository,
}) =>
    TokenInterceptor(
      token: token,
      onInvalidToken: () {
        TokenInterceptor(
            token: token,
            onInvalidToken: () {
              userRepository.removeAll();
              NavigationService().resetToScreen(welcomeRoute);
            });
      },
    );
