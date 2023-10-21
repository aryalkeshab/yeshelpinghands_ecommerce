import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/features/shared/layouts/custom_step_indicator.dart';
import 'package:flutter/material.dart';

class CheckoutStepper extends StatelessWidget {
  final int currentStep;
  final Widget child;
  final VoidCallback onProceed;

  const CheckoutStepper({
    Key? key,
    required this.child,
    required this.currentStep,
    required this.onProceed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: BaseWidget(builder: (context, config, theme) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: config.appEdgePadding(),
              vertical: config.appVerticalPaddingMedium()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              config.verticalSpaceMedium(),
              SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CustomStepIndicator(
                    currentStep: currentStep,
                    stepperList: ['Shipping', 'Payment', 'Summary'],
                  ),
                ),
              ),
              config.verticalSpaceMedium(),
              Expanded(
                  child: Align(alignment: Alignment.topLeft, child: child)),
              config.verticalSpaceMedium(),
              PrimaryButton(
                onPressed: (onProceed),
                label: 'Continue',
              ),
            ],
          ),
        );
      }),
    );
  }
}
