import 'package:flutter/material.dart';
import 'package:foody_app/widgets/foody_rating_label.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'foody_tag.dart';

class FoodyCardRestaurant extends StatelessWidget {
  const FoodyCardRestaurant({
    super.key,
    required this.imagePath,
    required this.category,
    required this.rating,
    required this.name,
    required this.address,
    required this.sittingTimes,
  });

  final String imagePath;
  final String category;
  final double rating;
  final String name;
  final String address;
  final List<String> sittingTimes;

  @override
  Widget build(BuildContext context) {
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
          onTap: () {},
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  // color: Colors.blueGrey,
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Skeleton.unite(
                          child: FoodyRatingLabel(rating: rating.toString()),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      address,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: sittingTimes
                              .map(
                                (sittingTime) => Skeleton.leaf(
                                  child: FoodyTag(
                                    width: 90,
                                    label: sittingTime,
                                    margin: const EdgeInsets.only(right: 10),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        Skeleton.ignore(
                          child: SizedBox(
                            height: 35,
                            width: 35,
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
                    )
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
