import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FoodyEmptyData extends StatelessWidget {
  const FoodyEmptyData({
    super.key,
    required this.title,
    required this.lottieAsset,
    this.lottieWidth,
    this.lottieHeight,
    this.lottieAnimated = true,
  });

  final String title;
  final String lottieAsset;
  final double? lottieWidth;
  final double? lottieHeight;
  final bool lottieAnimated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/lottie/$lottieAsset",
            animate: lottieAnimated,
            width: lottieWidth,
            height: lottieHeight,
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
