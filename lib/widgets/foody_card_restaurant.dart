import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/response/detailed_restaurant_response_dto.dart';
import 'package:foody_app/bloc/auth/auth_bloc.dart';
import 'package:foody_app/widgets/foody_button.dart';
import 'package:foody_app/widgets/foody_rating_label.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../routing/constants.dart';
import '../routing/navigation_service.dart';
import 'foody_tag.dart';

class FoodyCardRestaurant extends StatelessWidget {
  const FoodyCardRestaurant({
    super.key,
    required this.restaurant,
  });

  final DetailedRestaurantResponseDto restaurant;

  @override
  Widget build(BuildContext context) {
    Widget defaultImage() => Container(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
          height: 200,
          child: Icon(
            PhosphorIconsRegular.image,
            size: 45,
            color: Theme.of(context).primaryColor,
          ),
        );

    Widget roundedImage(Widget child) => ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: child,
        );

    return SizedBox(
      height: 400,
      child: Card(
        elevation: 0,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => NavigationService().navigateTo(
            restaurantDetailsRoute,
            arguments: {
              "restaurantId": restaurant.id,
              "authBloc": context.read<AuthBloc>(),
            },
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Skeletonizer.of(context).enabled
                    ? Container(color: Colors.grey.shade100)
                    : restaurant.photoUrl == null
                        ? roundedImage(defaultImage())
                        : roundedImage(
                            CachedNetworkImage(
                              fadeInDuration: const Duration(milliseconds: 300),
                              fadeOutDuration:
                                  const Duration(milliseconds: 300),
                              imageUrl: restaurant.photoUrl!,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: double.infinity,
                              placeholder: (_, __) => defaultImage(),
                              errorWidget: (_, __, ___) => defaultImage(),
                            ),
                          ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          restaurant.categories.isEmpty
                              ? ""
                              : restaurant.categories.first.name,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Skeleton.unite(
                          child: FoodyRatingLabel(
                              rating: restaurant.averageRating.toString()),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${restaurant.street}, ${restaurant.postalCode}, ${restaurant.city}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    restaurant.sittingTimes.isEmpty
                        ? FoodyButton(
                            label: "Prenota",
                            height: 45,
                            onPressed: () => NavigationService().navigateTo(
                              bookingFormRoute,
                              arguments: {"restaurant": restaurant},
                            ),
                          )
                        : Row(
                            spacing: 10,
                            children: [
                              ...restaurant.sittingTimes.map(
                                (sittingTime) => Skeleton.leaf(
                                  child: FoodyTag(
                                    width: 90,
                                    label: DateFormat('HH:mm')
                                        .format(sittingTime.start),
                                    elevation: 0,
                                    onTap: () => NavigationService().navigateTo(
                                      bookingFormRoute,
                                      arguments: {
                                        "restaurant": restaurant,
                                        "sittingTime": sittingTime,
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Skeleton.ignore(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: IconButton.outlined(
                                    padding: EdgeInsets.zero,
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    icon: const Icon(PhosphorIconsRegular.plus),
                                    iconSize: 20,
                                    onPressed: () =>
                                        NavigationService().navigateTo(
                                      bookingFormRoute,
                                      arguments: {"restaurant": restaurant},
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
