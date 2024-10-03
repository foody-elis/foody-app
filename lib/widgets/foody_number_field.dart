import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class FoodyNumberField extends StatelessWidget {
  const FoodyNumberField({
    super.key,
    required this.title,
    this.padding,
    this.margin,
    this.onChanged,
    this.required = false,
  });

  final String title;
  final EdgeInsetsGeometry? padding, margin;
  // final void Function()? onTap;
  final void Function(double)? onChanged;
  // final bool showCursor;
  // final bool readOnly;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: const TextStyle(color: Colors.grey),
                ),
                if (required)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            // width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SpinBox(
              min: 1,
              max: 999,
              // value: 50,
              decoration: const InputDecoration(border: InputBorder.none),
              onChanged: onChanged,
            ),
          ),
          /*if (errorText != null)
                          Text(
                            errorText!,
                            style: TextStyle(color: Theme.of(context).colorScheme.error),
                          ),*/
        ],
      ),
    );
  }
}
