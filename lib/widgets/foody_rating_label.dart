import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodyRatingLabel extends StatelessWidget {
  const FoodyRatingLabel({
    super.key,
    required this.rating,
    this.iconSize = 12,
    this.fontSize = 14,
  });

  final String rating;
  final double iconSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Theme.of(context).primaryColor,
          ),
          child: Icon(
            PhosphorIconsRegular.forkKnife,
            color: Colors.white,
            size: iconSize,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          rating.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
