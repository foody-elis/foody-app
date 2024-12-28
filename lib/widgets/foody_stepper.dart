import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodyStepper extends StatelessWidget {
  const FoodyStepper({
    super.key,
    required this.activeStep,
    this.onStepChanged,
  });

  final int activeStep;
  final void Function(int)? onStepChanged;

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: activeStep,
      lineStyle: LineStyle(
        defaultLineColor: Colors.grey,
        // lineLength: MediaQuery.sizeOf(context).width / 4,
        lineType: LineType.normal,
        //unreachedLineType: LineType.normal,
        // progress: state.progress,
        finishedLineColor: Theme.of(context).primaryColor,
        // progressColor: Theme.of(context).colorScheme.primary,
        lineThickness: 2,
      ),
      stepShape: StepShape.rRectangle,
      stepBorderRadius: 15,
      borderThickness: 2,
      //internalPadding: 10.0,
      stepRadius: 28,
      disableScroll: true,
      showTitle: false,
      finishedStepBackgroundColor: Colors.white,
      finishedStepBorderType: BorderType.normal,
      finishedStepBorderColor: Theme.of(context).colorScheme.primary,
      showLoadingAnimation: false,
      loadingAnimation: "./assets/lottie/loading.json",
      fitWidth: true,
      steps: [
        EasyStep(
          customStep: Opacity(
            opacity: activeStep >= 0 ? 1 : 0.3,
            child: const Icon(PhosphorIconsRegular.calendarDots),
            // ),
          ),
        ),
        EasyStep(
          customStep: Opacity(
            opacity: activeStep >= 1 ? 1 : 0.3,
            child: const Icon(PhosphorIconsRegular.clock),
          ),
        ),
        EasyStep(
          customStep: Opacity(
            opacity: activeStep >= 2 ? 1 : 0.3,
            child: const Icon(PhosphorIconsRegular.users),
          ),
        ),
        EasyStep(
          customStep: Opacity(
            opacity: activeStep >= 3 ? 1 : 0.3,
            child: const Icon(PhosphorIconsRegular.check),
          ),
        ),
      ],
      onStepReached: onStepChanged,
    );
  }
}
