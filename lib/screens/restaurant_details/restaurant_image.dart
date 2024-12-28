import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RestaurantImage extends StatelessWidget {
  const RestaurantImage({
    super.key,
    required this.enableSkeletonizer,
    required this.photoUrl,
  });

  final bool enableSkeletonizer;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    Widget defaultImage() => Container(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
          width: double.infinity,
          height: double.infinity,
          child: Skeleton.ignore(
            child: Icon(
              PhosphorIconsRegular.image,
              size: 45,
              color: Theme.of(context).primaryColor,
            ),
          ),
        );

    return Skeletonizer(
      enabled: enableSkeletonizer,
      child: SizedBox(
        height: 250,
        child: photoUrl == null
            ? defaultImage()
            : CachedNetworkImage(
                fadeInDuration: const Duration(milliseconds: 300),
                fadeOutDuration: const Duration(milliseconds: 300),
                imageUrl: photoUrl!,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
                placeholder: (_, __) => defaultImage(),
                errorWidget: (_, __, ___) => defaultImage(),
              ),
      ),
    );
  }
}
