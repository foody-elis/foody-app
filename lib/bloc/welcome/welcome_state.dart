import 'package:equatable/equatable.dart';
import 'package:lottie/lottie.dart';

class WelcomeState extends Equatable {
  final LottieComposition? composition;

  const WelcomeState({required this.composition});

  const WelcomeState.initial() : composition = null;

  WelcomeState copyWith({LottieComposition? composition}) {
    return WelcomeState(
      composition: composition ?? this.composition,
    );
  }

  @override
  List<Object?> get props => [composition];
}
