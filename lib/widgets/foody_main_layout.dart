import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:foody_app/bloc/bottom_nav_bar/bottom_nav_bar_event.dart';
import 'package:foody_app/widgets/foody_app_bar.dart';

class FoodyMainLayout extends HookWidget {
  const FoodyMainLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    void onScroll() => context.read<BottomNavBarBloc>().add(CanShowChanged(
        canShow: scrollController.position.userScrollDirection ==
            ScrollDirection.forward));

    useEffect(() {
      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPersistentHeader(delegate: FoodyAppBar(), pinned: true),
        SliverFillRemaining(child: child),
      ],
    );
  }
}
