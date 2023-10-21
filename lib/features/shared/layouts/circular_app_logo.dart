import 'package:flutter/material.dart';

import '../../../core/presentation/resources/ui_assets.dart';

class Circularapp_Icon extends StatelessWidget {
  const Circularapp_Icon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Image.asset(
        UIAssets.app_Icon,
        filterQuality: FilterQuality.high,
        height: 90,
      ),
    );
  }
}
