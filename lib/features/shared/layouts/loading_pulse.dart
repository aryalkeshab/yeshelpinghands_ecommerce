import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../core/presentation/resources/colors.dart';

class LoadingPulse extends StatelessWidget {
  const LoadingPulse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitWave(
      color: secondaryColorDark,
      size: 15.0,
    );
  }
}
