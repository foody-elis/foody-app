import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_event.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_state.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodyBottomNavBar extends HookWidget {
  const FoodyBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final indicatorWidth = useState(5.0);

    return BlocConsumer<BottomNavBarBloc, BottomNavBarState>(
      listenWhen: (previous, current) => previous.index != current.index,
      listener: (context, state) => indicatorWidth.value = 30,
      builder: (context, state) {
        return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
              height: 55,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 50,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: [
                    BottomNavigationBar(
                      selectedFontSize: 0.0,
                      unselectedFontSize: 0.0,
                      type: BottomNavigationBarType.fixed,
                      currentIndex: state.index,
                      onTap: (int value) => context
                          .read<BottomNavBarBloc>()
                          .add(IndexChanged(index: value)),
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      items: [
                        BottomNavigationBarItem(
                          icon: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              PhosphorIconsRegular.house,
                              color: Colors.grey,
                            ),
                          ),
                          activeIcon: Icon(PhosphorIconsFill.house,
                              color: Theme.of(context).primaryColor),
                          label: '',
                          tooltip: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              PhosphorIconsRegular.chatCircleDots,
                              color: Colors.grey,
                            ),
                          ),
                          activeIcon: Icon(
                            PhosphorIconsFill.chatCircleDots,
                            color: Theme.of(context).primaryColor,
                          ),
                          label: '',
                          tooltip: 'Chat',
                        ),
                        BottomNavigationBarItem(
                          icon: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              PhosphorIconsRegular.forkKnife,
                              color: Colors.grey,
                            ),
                          ),
                          activeIcon: Icon(
                            PhosphorIconsFill.forkKnife,
                            color: Theme.of(context).primaryColor,
                          ),
                          label: '',
                          tooltip: 'Ordini',
                        ),
                        BottomNavigationBarItem(
                          icon: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              PhosphorIconsRegular.userCircle,
                              color: Colors.grey,
                            ),
                          ),
                          activeIcon: Icon(
                            PhosphorIconsFill.userCircle,
                            color: Theme.of(context).primaryColor,
                          ),
                          label: '',
                          tooltip: 'Profilo',
                        ),
                      ],
                    ),
                    AnimatedPositioned(
                        bottom: 7,
                        left: switch (state.index) {
                          0 => 34,
                          1 => 107,
                          2 => 182,
                          3 => 254,
                          _ => 34,
                        },
                        curve: Curves.easeIn,
                        duration: const Duration(milliseconds: 600),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: indicatorWidth.value,
                          onEnd: () => indicatorWidth.value = 5,
                          height: 5,
                          curve: Curves.easeIn,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                        )),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
