import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/screens/home/search_bar.dart';
import 'package:foody_app/utils/app_bar_wave_clipper.dart';
import 'package:lottie/lottie.dart';

class FoodyAppBar extends SliverPersistentHeaderDelegate {
  final double topPadding = 40;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var adjustedShrinkOffset =
        shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = ((minExtent - adjustedShrinkOffset) * 0.7) + 15;

    return Stack(
      children: [
        const AppBarWave(height: 280),
        AnimatedOpacity(
          opacity: offset > 80 ? 1 : 0,
          duration: const Duration(milliseconds: 100),
          child: Padding(
            padding: EdgeInsets.only(
              top: topPadding,
              left: 16,
              right: MediaQuery.of(context).size.width / 2 - 10,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Foody",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Scopri e prenota il ristorante perfetto per te!",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: offset - 120,
          right: 0,
          child: AnimatedOpacity(
            opacity: offset > 80 ? 1 : 0,
            duration: const Duration(milliseconds: 100),
            child: FadeInRight(
              animate: true,
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 800),
              child: Lottie.asset(
                width: 250,
                height: 250,
                "assets/lottie/home_page.json",
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: topPadding + offset,
            left: 16,
            right: 16,
          ),
          child: const HomeSearchBar(),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 280;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
