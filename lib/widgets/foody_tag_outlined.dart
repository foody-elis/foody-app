import 'package:flutter/material.dart';

class FoodyTagOutlined extends StatelessWidget {
  const FoodyTagOutlined({
    super.key,
    required this.label,
    this.margin = EdgeInsets.zero,
    this.height,
    this.width,
    this.elevation = 0,
  });

  final String label;
  final EdgeInsetsGeometry margin;
  final double? height;
  final double? width;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card.outlined(
        elevation: elevation,
        margin: margin,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}
