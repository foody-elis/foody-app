import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../routing/constants.dart';
import '../../routing/navigation_service.dart';
import '../../widgets/foody_tag.dart';

class SittingTimesInfo extends StatelessWidget {
  const SittingTimesInfo({
    super.key,
    this.enableSkeletonizer = false,
    this.canEdit = false,
  });

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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (canEdit && !enableSkeletonizer)
                IconButton(
                  onPressed: () => NavigationService().navigateTo(
                    sittingTimesFormRoute,
                    arguments: {"isEditing": true},
                  ),
                  icon: const Icon(
                    PhosphorIconsRegular.pencilSimple,
                    size: 20,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ...List.generate(
                3,
                (index) => const Skeleton.leaf(
                  child: FoodyTag(
                    width: 90,
                    label: "HH:mm",
                    margin: EdgeInsets.only(right: 5),
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
