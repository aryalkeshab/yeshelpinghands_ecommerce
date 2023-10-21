import 'package:flutter/material.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';

import '../../../../../core/presentation/widgets/shimmer_widget.dart';

class ProductDetailsLoading extends StatelessWidget {
  const ProductDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: config.appEdgePadding()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShimmerWidget.rounded(
                width: double.maxFinite, height: config.appHeight(45)),
            config.verticalSpaceLarge(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerWidget.rounded(width: 150, height: 20, borderRadius: 3),
                ShimmerWidget.rounded(width: 100, height: 20, borderRadius: 3),
              ],
            ),
            config.verticalSpaceMedium(),
            ShimmerWidget.rounded(width: 100, height: 25, borderRadius: 3),
            config.verticalSpaceLarge(),
            ShimmerWidget.rounded(width: 300, height: 25, borderRadius: 3),
          ],
        ),
      );
    });
  }
}
