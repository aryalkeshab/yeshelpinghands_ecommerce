import 'package:yeshelpinghand/core/presentation/resources/ui_assets.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyOrderHistoryScreen extends StatelessWidget {
  const EmptyOrderHistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: config.appEdgePadding(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: config.appEdgePadding()),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  config.verticalSpaceMedium(),
                  Image.asset(
                    UIAssets.emptyOrderHistory,
                    height: 150,
                  ),
                  config.verticalSpaceLarge(),
                  Text(
                    'No Order History',
                    style: theme.textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w600, color: theme.primaryColor),
                  ),
                  config.verticalSpaceMedium(),
                  Text(
                    "Explore to get yourself some exciting products",
                    style: theme.textTheme.caption
                        ?.copyWith(fontSize: 14, color: theme.primaryColor),
                  ),
                  config.verticalSpaceLarge(),
                  PrimaryButton(
                      label: "Start Shopping",
                      onPressed: () {
                        Get.back();
                      }),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
