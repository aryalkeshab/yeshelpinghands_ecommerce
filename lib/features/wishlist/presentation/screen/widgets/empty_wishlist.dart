import 'package:yeshelpinghand/core/presentation/resources/ui_assets.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../dashboard/controllers/dashboard_controller.dart';

class EmptyWishListScreen extends StatelessWidget {
  const EmptyWishListScreen({
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
                    UIAssets.emptyWishlist,
                    height: 150,
                  ),
                  config.verticalSpaceLarge(),
                  Text(
                    'You have no items in your wish list',
                    style: theme.textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w600, color: theme.primaryColor),
                  ),
                  config.verticalSpaceMedium(),
                  Text(
                    "Tap any heart next to a product to favorite. We'll save them for you here!",
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
