import 'package:equatable/equatable.dart';
import '../../routing/constants.dart';

class FoodyState extends Equatable {
  final bool darkTheme;
  final String initialRoute;
  final bool showLoadingOverlay;

  const FoodyState({
    required this.darkTheme,
    required this.initialRoute,
    required this.showLoadingOverlay,
  });

  const FoodyState.initial(bool isLogged)
      : darkTheme = false,
        initialRoute = isLogged ? authenticatedRoute : welcomeRoute,
        showLoadingOverlay = false;

  FoodyState copyWith({
    bool? darkTheme,
    bool? copyWithTap,
    bool? showLoadingOverlay,
  }) {
    return FoodyState(
      darkTheme: darkTheme ?? this.darkTheme,
      initialRoute: initialRoute,
      showLoadingOverlay: showLoadingOverlay ?? this.showLoadingOverlay,
    );
  }

  @override
  List<Object> get props => [darkTheme, showLoadingOverlay];
}
