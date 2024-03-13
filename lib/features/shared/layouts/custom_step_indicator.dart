import 'package:flutter/material.dart';

class CustomStepIndicator extends StatelessWidget {
  ///Current step begins with 1
  final int currentStep;
  final List<String> stepperList;

  const CustomStepIndicator({
    Key? key,
    required this.stepperList,
    required this.currentStep,
  })  : assert(currentStep > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeStep = currentStep - 1;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(stepperList.length, (index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCircularIndicator(
                    context: context,
                    index: index,
                    activeStep: activeStep,
                    state: index == activeStep
                        ? StepState.edit
                        : index <= activeStep
                            ? StepState.completed
                            : StepState.indexed,
                  ),
                  const SizedBox(height: 5),
                  Text('${stepperList[index]}', textAlign: TextAlign.center),
                ],
              ),
              if (index != stepperList.length - 1)
                Container(
                  margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  width: 40,
                  color: Theme.of(context).disabledColor,
                  height: 1,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildCircularIndicator(
      {required BuildContext context,
      required int index,
      required int activeStep,
      required StepState state}) {
    switch (state) {
      case StepState.indexed:
        return _CircularStepIcon(
            color: Colors.white,
            child: Text(
              '${index + 1}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
            ));
      case StepState.completed:
        return const _CircularStepIcon(
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 20,
          ),
        );
      case StepState.edit:
        return const _CircularStepIcon(
          child: Icon(Icons.edit, size: 18, color: Colors.white),
        );
      default:
        return const _CircularStepIcon(child: Icon(Icons.check, size: 20));
    }
  }
}

class _CircularStepIcon extends StatelessWidget {
  final Color? color;
  final Widget child;

  const _CircularStepIcon({
    Key? key,
    this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      radius: 14,
      child: CircleAvatar(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        radius: 12,
        child: child,
      ),
    );
  }
}

enum StepState {
  ///A step with number in its circle
  indexed,

  ///A step with pencil icon in its circle
  edit,

  ///A step with check icon in its circle
  completed,
}
