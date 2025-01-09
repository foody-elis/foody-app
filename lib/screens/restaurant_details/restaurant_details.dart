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
import 'package:foody_app/utils/show_snackbar.dart';
import 'package:foody_app/widgets/foody_button.dart';
import 'package:foody_app/widgets/foody_rating_label.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../../bloc/bottom_nav_bar/bottom_nav_bar_event.dart';
import '../../bloc/foody/foody_bloc.dart';
import '../../bloc/foody/foody_event.dart';
import '../../routing/constants.dart';
import '../../routing/navigation_service.dart';

class RestaurantDetails extends HookWidget {
  const RestaurantDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final isOwner = useMemoized(
        () => context.read<RestaurantDetailsBloc>().restaurantId == null);
    final showShadowFixedButton = useState(true);

    useEffect(() {
      void listener() {
        if (isOwner) {
          // changeBottomNavBarState
          context.read<BottomNavBarBloc>().add(CanShowChanged(
              canShow: scrollController.position.userScrollDirection ==
                  ScrollDirection.forward));
        } else {
          // changeShadowFixedButtonState
          showShadowFixedButton.value =
              scrollController.position.maxScrollExtent !=
                  scrollController.position.pixels;
        }
      }

      scrollController.addListener(listener);

      return () => scrollController.removeListener(listener);
    }, []);

    return BlocConsumer<RestaurantDetailsBloc, RestaurantDetailsState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showSnackBar(context: context, msg: state.apiError);
        }

        context
            .read<FoodyBloc>()
            .add(ShowLoadingOverlayChanged(show: state.isUpdatingImage));
      },
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
                    photoUrl: state.restaurant.photoUrl,
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
                        if (state.restaurant.sittingTimes.isNotEmpty ||
                            isOwner) ...[
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
                          restaurantId: state.restaurant.id,
                          reviews: state.restaurant.reviews,
                        ),
                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (!isOwner && !state.isFetching)
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
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 20,
                    bottom: 10,
                  ),
                  child: SafeArea(
                    top: false,
                    child: FoodyButton(
                      label: "PRENOTA",
                      height: 50,
                      onPressed: () => NavigationService().navigateTo(
                        bookingFormRoute,
                        arguments: {
                          "restaurant": context
                              .read<RestaurantDetailsBloc>()
                              .state
                              .restaurant,
                        },
                      ),
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
