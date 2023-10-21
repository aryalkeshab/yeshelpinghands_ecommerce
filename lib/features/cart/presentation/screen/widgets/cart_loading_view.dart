import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';

class CartLoadingView extends StatelessWidget {
  const CartLoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return ListView.separated(
          itemCount: 2,
          separatorBuilder: (context, index) => config.verticalSpaceMedium(),
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget.rounded(
                    width: config.appWidth(25),
                    height: config.appHeight(12),
                    borderRadius: 0),
                config.horizontalSpaceSmall(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShimmerWidget.rounded(
                            width: config.appWidth(40),
                            height: config.appHeight(2),
                            borderRadius: 5),
                        config.verticalSpaceSmall(),
                        ShimmerWidget.rounded(
                            width: config.appWidth(15),
                            height: config.appHeight(2),
                            borderRadius: 3),
                      ],
                    ),
                    config.verticalSpaceLarge(),
                    ShimmerWidget.rounded(
                        width: config.appWidth(60),
                        height: config.appHeight(2),
                        borderRadius: 3),
                  ],
                )
              ],
            );
          });
    });
  }
}
