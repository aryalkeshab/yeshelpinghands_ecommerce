import 'package:flutter/material.dart';

import '../../../../../core/presentation/resources/colors.dart';
import '../../../../../core/presentation/widgets/base_widget.dart';
import '../../../../../core/utils/number_parser.dart';

class PriceRangeSlider extends StatefulWidget {
  final double? previousMin;
  final double? previousMax;
  final double lowerLimit;
  final double upperLimit;
  final Function(double, double) onRangeUpdate;

  const PriceRangeSlider({
    Key? key,
    required this.upperLimit,
    required this.lowerLimit,
    required this.onRangeUpdate,
    this.previousMax,
    this.previousMin,
  }) : super(key: key);

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  @override
  initState() {
    super.initState();

    if (widget.previousMin != null) {
      _minValue = widget.previousMin!;
    } else {
      _minValue = widget.lowerLimit;
    }
    if (widget.previousMax != null) {
      _maxValue = widget.previousMax!;
    } else {
      _maxValue = widget.upperLimit;
    }
  }

  double _minValue = 0;
  double _maxValue = 50;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, config, theme) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Price",
              style: theme.textTheme.headline6?.copyWith(color: primaryColor),
            ),
            RangeSlider(
              values: RangeValues(_minValue, _maxValue),
              min: widget.lowerLimit,
              max: widget.upperLimit,
              divisions: 50,
              onChanged: (RangeValues values) {
                setState(() {
                  _minValue = values.start;
                  _maxValue = values.end;
                });

                widget.onRangeUpdate(_minValue, _maxValue);
              },
              activeColor: primaryColor,
              inactiveColor: grey500,
              labels: RangeLabels(
                _minValue.round().toString(),
                _maxValue.round().toString(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    'Min: ${NumberParser.twoDecimalDigit(_minValue.toString())}'),
                Text(
                    'Max: ${NumberParser.twoDecimalDigit(_maxValue.toString())}'),
              ],
            ),
          ],
        );
      },
    );
  }
}
