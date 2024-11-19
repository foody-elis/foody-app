import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RestaurantImage extends StatelessWidget {
  const RestaurantImage({
    super.key,
    required this.enableSkeletonizer,
    required this.canEdit,
  });

  final bool enableSkeletonizer;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enableSkeletonizer,
      child: Container(
        alignment: Alignment.topRight,
        height: 250,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ristorante.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: canEdit
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(PhosphorIconsRegular.pencilSimple),
                    style: IconButton.styleFrom(
                      shape: const CircleBorder(),
                      iconSize: 20,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
