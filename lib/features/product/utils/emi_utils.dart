import 'dart:math';

int calculateEmi(
    {required double principle,
    int monthlyRate = 12,
    required int timeInMonths}) {
  final annualRate = monthlyRate / (12 * 100);

  final emi = principle *
      annualRate *
      (pow(1 + annualRate, timeInMonths) /
          (pow(1 + annualRate, timeInMonths) - 1));
  return emi.toInt();
}
