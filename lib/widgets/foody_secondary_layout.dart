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
    this.expandedBodyHeight = 0.8,
    this.startWithExpandedBody = false,
    this.onRefresh,
    this.bodySpacing = 0,
  }) : assert(subtitle == null || subtitleWidget == null,
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
  final double expandedBodyHeight;
  final bool startWithExpandedBody;
  final Future<void> Function()? onRefresh;
  final double bodySpacing;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    if (showBottomNavBar) {
      void onScroll() => context.read<BottomNavBarBloc>().add(CanShowChanged(
          canShow: scrollController.position.userScrollDirection ==
              ScrollDirection.forward));

      useEffect(() {
        scrollController.addListener(onScroll);

        return () => scrollController.removeListener(onScroll);
      }, []);
    }

    // final color = Theme.of(context).colorScheme.primary.withAlpha(200);
    const backgroundColor = Color(0xff0e4a47);

    final foodyDraggableHome = FoodyDraggableHome(
      physics: onRefresh == null ? null : const ClampingScrollPhysics(),
      expandedBody: expandedBody,
      scrollController: scrollController,
      stretchMaxHeight: expandedBodyHeight,
      startWithExpandedBody: startWithExpandedBody,
      appBarColor: backgroundColor,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      headerExpandedHeight: headerExpandedHeight,
      curvedBodyRadius: 20,
      headerWidget: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleWidget != null
                  ? titleWidget!
                  : Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
              if (subtitleWidget != null) subtitleWidget!,
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixedDim,
                  ),
                )
            ],
          ),
        ),
      ),
      body: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            spacing: bodySpacing,
            children: body,
          ),
        ),
      ],
    );

    return onRefresh == null
        ? foodyDraggableHome
        : RefreshIndicator(onRefresh: onRefresh!, child: foodyDraggableHome);
  }
}
