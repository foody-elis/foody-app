import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_state.dart';
import 'package:foody_app/widgets/foody_bottom_nav_bar.dart';

class FoodyPageView extends HookWidget {
  //late PageController _controller;
  final _duration = const Duration(milliseconds: 500);

  final Widget home;
  final Widget chats;
  final Widget orders;
  final Widget profile;

  const FoodyPageView({
    super.key,
    required this.home,
    required this.chats,
    required this.orders,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();

    return BlocConsumer<BottomNavBarBloc, BottomNavBarState>(
      listener: (context, state) {
        pageController.animateToPage(
          state.index,
          duration: _duration,
          curve: Curves.easeInOut,
        );
      },
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          /*backgroundColor: // customAppBar
            ? Theme.of(context).scaffoldBackgroundColor
            : null,*/
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            // index: widget.index,
            children: [
              home,
              chats,
              orders,
              profile,
            ],
          ),
          bottomNavigationBar: FadeInUp(
            animate: state.canShow,
            duration: const Duration(milliseconds: 500),
            child: const FoodyBottomNavBar(),
          ),
        );
      },
    );
  }
}
