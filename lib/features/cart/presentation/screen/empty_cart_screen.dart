import 'package:yeshelpinghand/core/presentation/resources/ui_assets.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../dashboard/controllers/dashboard_controller.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, config, theme) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: config.appEdgePadding()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: config.appEdgePadding()),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    config.verticalSpaceMedium(),
                    Image.asset(
                      UIAssets.emptyCart,
                    ),
                    config.verticalSpaceLarge(),
                    Text(
                      'Your cart is empty',
                      style: theme.textTheme.bodyText1
                          ?.copyWith(fontWeight: FontWeight.w600, color: theme.primaryColor),
                    ),
                    config.verticalSpaceMedium(),
                    PrimaryButton(
                        label: "Start Shopping",
                        onPressed: () {
                          Get.put(DashboardController()).changeTabIndex(0);
                        }),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
