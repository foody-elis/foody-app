import 'package:flutter/material.dart';
import 'package:foody_app/widgets/foody_button.dart';
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
    this.onTap,
  });

  final String imagePath;
  final String category;
  final double rating;
  final String name;
  final String address;
  final List<String> sittingTimes;
  final void Function()? onTap;

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
          onTap: onTap,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    const SizedBox(height: 10),
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      address,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    sittingTimes.isEmpty
                        ? const FoodyButton(label: "Prenota", height: 45)
                        : Row(
                            spacing: 10,
                            children: [
                              ...sittingTimes.map(
                                (sittingTime) => Skeleton.leaf(
                                  child: FoodyTag(
                                    width: 90,
                                    label: sittingTime,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
