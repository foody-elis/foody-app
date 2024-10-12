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
    this.titleWidget,
    this.subtitle,
    this.subtitleWidget,
    this.showBottomNavBar = true,
    required this.body,
    this.expandedBody,
    this.horizontalPadding = 20,
    this.headerExpandedHeight = 0.22,
  })  :assert(
            (subtitle == null && subtitleWidget != null) ||
                (subtitle != null && subtitleWidget == null),
            "subtitle and subtitleWidget cannot be set at the same time");

  final bool showBottomNavBar;
  final String title;
  final Widget? titleWidget;
  final String? subtitle;
  final Widget? subtitleWidget;
  final List<Widget> body;
  final Widget? expandedBody;
  final double horizontalPadding;
  final double headerExpandedHeight;

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
      expandedBody: expandedBody,
      scrollController: scrollController,
      stretchMaxHeight: 0.8,
      extendBody: showBottomNavBar,
      appBarColor: Theme.of(context).colorScheme.surfaceContainer,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      headerExpandedHeight: headerExpandedHeight,
      curvedBodyRadius: 20,
      headerWidget: Container(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleWidget != null ? titleWidget! : Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              subtitleWidget != null ? subtitleWidget! : Text(
                subtitle!,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      body: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(children: body),
        ),
      ],
      // floatingActionButton: floatingActionButton,
    );
  }
}
