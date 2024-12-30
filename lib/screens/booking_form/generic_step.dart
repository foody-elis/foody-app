import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_app/bloc/booking_form/booking_form_event.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/booking_form/booking_form_bloc.dart';
import '../../bloc/booking_form/booking_form_state.dart';

class BookingFormGenericStep extends HookWidget {
  const BookingFormGenericStep({
    super.key,
    required this.step,
    required this.title,
    required this.titleWhenPassed,
    required this.child,
    required this.childWhenPassed,
    this.isFirstStep = false,
    this.childHeight,
  });

  final int step;
  final String title;
  final String titleWhenPassed;
  final Widget Function(BoxConstraints) child;
  final Widget Function(BoxConstraints) childWhenPassed;
  final bool isFirstStep;
  final double? childHeight;

  @override
  Widget build(BuildContext context) {
    final showChild = useState(false);

    return BlocConsumer<BookingFormBloc, BookingFormState>(
      listener: (context, state) {
        if (state.activeStep == step) showChild.value = true;
      },
      builder: (context, state) {
        final isCurrentStep = state.activeStep == step;
        final isStepPassed = state.activeStep > step;

        Widget content() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                Text(
                  isStepPassed ? titleWhenPassed : title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Stack(
                  children: [
                    AnimatedOpacity(
                      opacity: isCurrentStep ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: showChild.value
                          ? SizedBox(
                              height: childHeight,
                              width: double.infinity,
                              child: LayoutBuilder(
                                builder: (
                                  BuildContext context,
                                  BoxConstraints constraints,
                                ) =>
                                    child(constraints),
                              ),
                            )
                          : const SizedBox.shrink(),
                      onEnd: () => showChild.value = isCurrentStep,
                    ),
                    AnimatedOpacity(
                      opacity: 1 - (isCurrentStep ? 1 : 0),
                      duration: const Duration(milliseconds: 300),
                      child: isStepPassed
                          ? LayoutBuilder(
                              builder: (
                                BuildContext context,
                                BoxConstraints constraints,
                              ) =>
                                  Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  childWhenPassed(constraints),
                                  IconButton(
                                    alignment: Alignment.topCenter,
                                    onPressed: () => context
                                        .read<BookingFormBloc>()
                                        .add(StepChanged(step: step)),
                                    icon: const Icon(
                                      PhosphorIconsRegular.pencilSimple,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : null,
                    ),
                  ],
                )
              ],
            );

        return isFirstStep
            ? content()
            : isCurrentStep || isStepPassed
                ? FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 300),
                    child: content())
                : const SizedBox.shrink();
      },
    );
  }
}
