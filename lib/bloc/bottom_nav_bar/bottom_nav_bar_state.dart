import 'package:equatable/equatable.dart';

class BottomNavBarState extends Equatable {
  final int index;
  final bool canShow;

  const BottomNavBarState({
    required this.index,
    required this.canShow,
  });

  const BottomNavBarState.initial()
      : index = 0,
        canShow = true;

  BottomNavBarState copyWith({
    int? index,
    bool? canShow,
  }) {
    return BottomNavBarState(
      index: index ?? this.index,
      canShow: canShow ?? this.canShow,
    );
  }

  @override
  List<Object> get props => [index, canShow];
}
