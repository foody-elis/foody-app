import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodyTextField extends StatelessWidget {
  const FoodyTextField({
    super.key,
    required this.title,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.padding,
    this.margin,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.showCursor = true,
    this.readOnly = false,
    this.errorText,
    this.required = false,
    this.textArea = false,
    this.label,
  });

  final String title;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final EdgeInsetsGeometry? padding, margin;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final bool showCursor;
  final bool readOnly;
  final String? errorText;
  final bool required;
  final bool textArea;
  final String? label;

  @override
  Widget build(BuildContext context) {
    if(label != null) controller?.text = label!;

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
            width: MediaQuery.of(context).size.width,
            height: textArea ? 100 : 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              maxLines: textArea ? 5 : 1,
              keyboardType: textArea ? TextInputType.multiline : null,
              textAlignVertical: suffixIcon != null || errorText != null
                  ? TextAlignVertical.center
                  : null,
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                // label: label != null ? Text(label!) : null,
                // alignLabelWithHint: false,
                hintText: hint,
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
                contentPadding:  EdgeInsets.only(left: 16, right: 16, top: textArea ? 8 : 0),
                border: InputBorder.none,
                suffixIcon: errorText == null
                    ? suffixIcon
                    : const Icon(
                        PhosphorIconsRegular.warningCircle,
                        color: Colors.red,
                      ),
              ),
              onTap: onTap,
              onChanged: onChanged,
              showCursor: showCursor,
              readOnly: readOnly,
            ),
          ),
          if (errorText != null)
            Text(
              errorText!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
        ],
      ),
    );
  }
}
