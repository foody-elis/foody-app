import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_bloc.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_state.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_description.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_image.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_info.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_menu.dart';
import 'package:foody_app/screens/restaurant_details/restaurant_reviews.dart';
import 'package:foody_app/screens/restaurant_details/sitting_times_info.dart';
import 'package:foody_app/widgets/foody_rating_label.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../../bloc/bottom_nav_bar/bottom_nav_bar_event.dart';

class RestaurantDetails extends HookWidget {
  const RestaurantDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final isOwner = useMemoized(
        () => context.read<RestaurantDetailsBloc>().restaurantId == null);

    if (isOwner) {
      void onScroll() => context.read<BottomNavBarBloc>().add(CanShowChanged(
          canShow: scrollController.position.userScrollDirection ==
              ScrollDirection.forward));

      useEffect(() {
        scrollController.addListener(onScroll);

        return () => scrollController.removeListener(onScroll);
      }, [scrollController]);
    }

    return BlocBuilder<RestaurantDetailsBloc, RestaurantDetailsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              RestaurantImage(
                enableSkeletonizer: state.isFetching,
                canEdit: isOwner,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RestaurantInfo(
                      restaurant: state.restaurant,
                      enableSkeletonizer: state.isFetching,
                      canEdit: isOwner,
                    ),
                    const Divider(height: 40),
                    SittingTimesInfo(
                      enableSkeletonizer: state.isFetching,
                      canEdit: isOwner,
                    ),
                    const Divider(height: 40),
                    Skeletonizer(
                      enabled: state.isFetching,
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
                      description: state.restaurant.description,
                      enableSkeletonizer: state.isFetching,
                    ),
                    const SizedBox(height: 20),
                    RestaurantMenu(
                      enableSkeletonizer: state.isFetching,
                      canEdit: isOwner,
                      restaurantId: state.restaurant.id,
                    ),
                    const SizedBox(height: 20),
                    RestaurantReviews(enableSkeletonizer: state.isFetching),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
