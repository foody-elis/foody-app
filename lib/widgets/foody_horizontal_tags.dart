import 'package:flutter/material.dart';
import 'package:foody_app/widgets/foody_tag_outlined.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FoodyHorizontalTags extends StatelessWidget {
  const FoodyHorizontalTags({
    super.key,
    this.enableSkeletonizer = false,
    required this.itemCount,
    required this.tagBuilder,
    this.padding,
  });

  final bool enableSkeletonizer;
  final int itemCount;
  final String Function(BuildContext, int) tagBuilder;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Skeletonizer(
        containersColor: Colors.grey.shade100,
        enabled: enableSkeletonizer,
        child: ListView.builder(
          padding: padding,
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) => FoodyTagOutlined(
            margin: const EdgeInsets.only(right: 5),
            label: tagBuilder(context, index),
          ),
        ),
      ),
    );
  }
}
