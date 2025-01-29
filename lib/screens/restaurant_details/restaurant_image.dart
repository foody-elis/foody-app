import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_bloc.dart';
import 'package:foody_app/routing/navigation_service.dart';
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
        child: Stack(
          children: [
            photoUrl == null
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
            if (context.read<RestaurantDetailsBloc>().restaurantId != null)
              Positioned(
                left: 10,
                top: 0,
                child: Skeleton.ignore(
                  child: SafeArea(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => NavigationService().goBack(),
                        borderRadius: BorderRadius.circular(100),
                        child: Ink(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(PhosphorIconsRegular.arrowLeft),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
