import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_bloc.dart';
import 'package:foody_app/bloc/restaurant_details/restaurant_details_event.dart';
import 'package:foody_app/dto/response/sitting_time_response_dto.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../routing/constants.dart';
import '../../routing/navigation_service.dart';
import '../../widgets/foody_tag.dart';

class SittingTimesInfo extends StatelessWidget {
  const SittingTimesInfo({
    super.key,
    required this.sittingTimes,
    this.enableSkeletonizer = false,
    this.canEdit = false,
  });

  final List<SittingTimeResponseDto> sittingTimes;
  final bool canEdit;
  final bool enableSkeletonizer;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enableSkeletonizer,
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Orari in cui prenotare",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (canEdit && !enableSkeletonizer)
                IconButton(
                  onPressed: () async {
                    await NavigationService().navigateTo(
                      sittingTimesFormRoute,
                      arguments: {"isEditing": true},
                    );

                    if (!context.mounted) return;
                    context
                        .read<RestaurantDetailsBloc>()
                        .add(FetchRestaurant());
                  },
                  icon: const Icon(
                    PhosphorIconsRegular.pencilSimple,
                    size: 20,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            spacing: 10,
            children: [
              ...sittingTimes.map(
                (sittingTime) => Skeleton.leaf(
                  child: FoodyTag(
                    width: 90,
                    label: DateFormat('HH:mm').format(sittingTime.start),
                    elevation: 0,
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    icon: const Icon(PhosphorIconsRegular.plus),
                    iconSize: 20,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
