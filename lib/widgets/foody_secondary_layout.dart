import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_event.dart';

import 'foody_draggable_home.dart';

class FoodySecondaryLayout extends HookWidget {
  const FoodySecondaryLayout({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBottomNavBar = true,
    required this.body,
  });

  final bool showBottomNavBar;
  final String title;
  final String subtitle;
  final List<Widget> body;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    if (showBottomNavBar) {
      void onScroll() => context.read<BottomNavBarBloc>().add(CanShowChanged(
          canShow: scrollController.position.userScrollDirection ==
              ScrollDirection.forward));

      useEffect(() {
        if (showBottomNavBar) {
          scrollController.addListener(onScroll);
        }

        return () => scrollController.removeListener(onScroll);
      }, [scrollController]);
    }

    return FoodyDraggableHome(
      scrollController: scrollController,
      extendBody: showBottomNavBar,
      appBarColor: Theme.of(context).colorScheme.surfaceContainer,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      headerExpandedHeight: 0.22,
      curvedBodyRadius: 20,
      headerWidget: Container(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      body: body,
      // floatingActionButton: floatingActionButton,
    );
  }
}
