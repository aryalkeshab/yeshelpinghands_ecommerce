import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/features/dashboard/controllers/dashboard_controller.dart';

class OrderSuccessDialog extends StatelessWidget {
  const OrderSuccessDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false), //false
      child: Center(
        child: BaseWidget(builder: (context, config, theme) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding:
                EdgeInsets.symmetric(vertical: 15, horizontal: config.appVerticalPaddingLarge()),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: BaseWidget(builder: (context, config, theme) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Your order has been placed", style: theme.textTheme.headline5),
                  config.verticalSpaceLarge(),
                  const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.done, color: Colors.white),
                  ),
                  config.verticalSpaceMedium(),
                  Text("Thank you for your purchase!", style: theme.textTheme.bodyText1),
                  // config.verticalSpaceMedium(),
                  // Text(
                  //     "You will recieve an email with the details of your order",
                  //     textAlign: TextAlign.center,
                  //     style: theme.textTheme.bodyText2),

                  // Text("Your order ID: 121212456",style: theme.textTheme.bodyText2),
                  config.verticalSpaceLarge(),
                  PrimaryButton(
                    width: 200,
                    labelColor: Colors.white,
                    color: theme.primaryColor,
                    label: "Continue Shopping",
                    onPressed: () {
                      Get.until((route) => route.settings.name == Routes.dashboard);
                      Get.find<DashboardController>().changeTabIndex(0);
                    },
                  )
                ],
              );
            }),
          );
        }),
      ),
    );
  }
}
