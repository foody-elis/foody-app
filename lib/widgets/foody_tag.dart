import 'package:flutter/material.dart';

class FoodyTag extends StatelessWidget {
  const FoodyTag({
    super.key,
    required this.label,
    this.height = 40,
    this.width = 90,
    this.margin = EdgeInsets.zero,
    this.elevation = 3,
  });

  final String label;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        elevation: elevation,
        /*shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),*/
        color: Theme.of(context).colorScheme.primary,
        margin: margin,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
