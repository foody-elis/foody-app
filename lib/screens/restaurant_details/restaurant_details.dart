import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/dto/response/restaurant_response_dto.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_description.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_info.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_menu.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_reviews.dart';
import 'package:foody_app/widgets/foody_rating_label.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../../bloc/bottom_nav_bar/bottom_nav_bar_event.dart';
import '../../widgets/foody_horizontal_tags.dart';

class RestaurantDetails extends HookWidget {
  const RestaurantDetails({
    super.key,
    required this.restaurant,
    required this.enableSkeletonizer,
    this.isOwner = false,
  });

  final RestaurantResponseDto restaurant;
  final bool enableSkeletonizer;
  final bool isOwner;

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

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RestaurantInfo(
                  enableSkeletonizer: enableSkeletonizer,
                  name: restaurant.name,
                  address:
                      "${restaurant.street}, ${restaurant.postalCode}, ${restaurant.city}",
                  phoneNumber: restaurant.phoneNumber,
                ),
                const Divider(height: 40),
                FoodyHorizontalTags(
                  enableSkeletonizer: enableSkeletonizer,
                  itemCount: restaurant.categories.length,
                  tagBuilder: (context, index) =>
                      restaurant.categories[index].name,
                ),
                const SizedBox(height: 20),
                Skeletonizer(
                  enabled: enableSkeletonizer,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Skeleton.unite(
                          child: FoodyRatingLabel(
                            rating: "4.5",
                            iconSize: 20,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text("0 recensioni su Foody"),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 40),
                RestaurantDescription(
                  description: restaurant.description,
                  enableSkeletonizer: enableSkeletonizer,
                ),
                const SizedBox(height: 20),
                RestaurantMenu(enableSkeletonizer: enableSkeletonizer),
                const SizedBox(height: 20),
                RestaurantReviews(enableSkeletonizer: enableSkeletonizer),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
