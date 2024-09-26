import 'package:equatable/equatable.dart';
import '../../routing/constants.dart';

class FoodyState extends Equatable {
  final bool darkTheme;
  final String initialRoute;

  const FoodyState({
    required this.darkTheme,
    required this.initialRoute,
  });

  const FoodyState.initial() :
          darkTheme = false,
          initialRoute = welcomeRoute;

  FoodyState copyWith({bool? darkTheme, bool? copyWithTap}) {
    return FoodyState(
      darkTheme: darkTheme ?? this.darkTheme,
      initialRoute: initialRoute,
    );
  }

  @override
  List<Object> get props => [darkTheme];
}
