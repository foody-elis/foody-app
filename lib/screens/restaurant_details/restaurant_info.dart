import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({
    super.key,
    required this.name,
    required this.address,
    required this.phoneNumber,
    this.enableSkeletonizer = false,
  });

  final String name;
  final String address;
  final String phoneNumber;
  final bool enableSkeletonizer;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enableSkeletonizer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              const Icon(
                PhosphorIconsRegular.mapPin,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                address,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                PhosphorIconsRegular.phone,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                phoneNumber,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
