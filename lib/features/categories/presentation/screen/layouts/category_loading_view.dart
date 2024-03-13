import 'package:flutter/material.dart';
import '../../../../../core/presentation/widgets/base_widget.dart';
import '../../../../../core/presentation/widgets/shimmer_widget.dart';

class CategoryLoadingView extends StatelessWidget {
  const CategoryLoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: config.appEdgePadding(),
          vertical: config.appVerticalPaddingMedium(),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  9,
                  (index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShimmerWidget.rounded(
                            width: config.appWidth(26),
                            height: index == 4 || index == 6 || index == 7
                                ? config.appHeight(4)
                                : config.appHeight(3)),
                        config.verticalSpaceLarge(),
                      ],
                    );
                  },
                ),
              ),
            ),
            config.horizontalSpaceMedium(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget.rounded(width: config.appWidth(45), height: config.appHeight(2)),
                config.verticalSpaceLarge(),
                ShimmerWidget.rounded(width: config.appWidth(35), height: config.appHeight(2)),
                config.verticalSpaceLarge(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget.rounded(width: config.appWidth(15), height: config.appHeight(10)),
                    config.horizontalSpaceLarge(),
                    ShimmerWidget.rounded(width: config.appWidth(15), height: config.appHeight(10)),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
