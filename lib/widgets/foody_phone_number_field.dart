import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodyPhoneNumberField extends HookWidget {
  const FoodyPhoneNumberField({
    super.key,
    required this.title,
    this.padding,
    this.margin,
    this.onInputChanged,
    this.required = false,
    this.errorText,
    this.suffixIcon,
    this.label,
  });

  final String title;
  final EdgeInsetsGeometry? padding, margin;
  final void Function(PhoneNumber)? onInputChanged;
  final bool required;
  final String? errorText;
  final Widget? suffixIcon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();

    useEffect(() {
      if (label != null) textController.text = label!;
      return null;
    }, [label]);

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
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InternationalPhoneNumberInput(
              textFieldController: textController,
              onInputChanged: onInputChanged,
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                useBottomSheetSafeArea: true,
                trailingSpace: false,
                setSelectorButtonAsPrefixIcon: true,
                leadingPadding: 15,
              ),
              searchBoxDecoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Cerca",
              ),
              spaceBetweenSelectorAndTextField: 0.0,
              ignoreBlank: false,
              initialValue: PhoneNumber(isoCode: 'IT'),
              formatInput: true,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              inputDecoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: errorText == null
                    ? suffixIcon
                    : const Icon(
                        PhosphorIconsRegular.warningCircle,
                        color: Colors.red,
                      ),
              ),
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
