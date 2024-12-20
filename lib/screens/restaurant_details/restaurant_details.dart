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
import 'package:foody_app/widgets/foody_button.dart';
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
    final showShadowFixedButton = useState(true);

    if (isOwner) {
      void changeBottomNavBarState() =>
          context.read<BottomNavBarBloc>().add(CanShowChanged(
              canShow: scrollController.position.userScrollDirection ==
                  ScrollDirection.forward));

      useEffect(() {
        scrollController.addListener(changeBottomNavBarState);

        return () => scrollController.removeListener(changeBottomNavBarState);
      }, []);
    } else {
      void changeShadowFixedButtonState() => showShadowFixedButton.value =
          scrollController.position.maxScrollExtent !=
              scrollController.position.pixels;

      useEffect(() {
        scrollController.addListener(changeShadowFixedButtonState);

        return () =>
            scrollController.removeListener(changeShadowFixedButtonState);
      }, []);
    }

    return BlocBuilder<RestaurantDetailsBloc, RestaurantDetailsState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  RestaurantImage(
                    enableSkeletonizer: state.isFetching,
                    canEdit: isOwner,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RestaurantInfo(
                          restaurant: state.restaurant,
                          enableSkeletonizer: state.isFetching,
                          canEdit: isOwner,
                        ),
                        if (state.restaurant.sittingTimes.isNotEmpty) ...[
                          const Divider(height: 40),
                          SittingTimesInfo(
                            sittingTimes: state.restaurant.sittingTimes,
                            enableSkeletonizer: state.isFetching,
                            canEdit: isOwner,
                          ),
                        ],
                        const Divider(height: 40),
                        Skeletonizer(
                          enabled: state.isFetching,
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Skeleton.unite(
                                  child: FoodyRatingLabel(
                                    rating: state.restaurant.averageRating
                                        .toString(),
                                    iconSize: 20,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                    "${state.restaurant.reviews.length} recensioni su Foody"),
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
                          dishes: state.restaurant.dishes,
                        ),
                        const SizedBox(height: 20),
                        RestaurantReviews(
                          enableSkeletonizer: state.isFetching,
                          reviews: state.restaurant.reviews,
                        ),
                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (!isOwner)
              Positioned(
                bottom: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: showShadowFixedButton.value
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, -2),
                            ),
                          ]
                        : null,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: const SafeArea(
                    top: false,
                    child: FoodyButton(
                      label: "PRENOTA",
                      height: 50,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
