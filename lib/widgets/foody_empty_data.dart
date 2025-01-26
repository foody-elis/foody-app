import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FoodyEmptyData extends StatelessWidget {
  const FoodyEmptyData({
    super.key,
    required this.title,
    this.description,
    required this.lottieAsset,
    this.lottieWidth,
    this.lottieHeight,
    this.lottieAnimate = true,
    this.lottieRepeat = true,
    this.containerHeight,
    this.spacing = 10,
  });

  final String title;
  final String? description;
  final String lottieAsset;
  final double? lottieWidth;
  final double? lottieHeight;
  final bool lottieAnimate;
  final bool lottieRepeat;
  final double? containerHeight;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: containerHeight ?? MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Column(
        spacing: spacing,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/lottie/$lottieAsset",
            animate: lottieAnimate,
            width: lottieWidth,
            height: lottieHeight,
            repeat: lottieRepeat,
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          if (description != null)
            Text(
              description!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
