import 'package:yeshelpinghand/core/presentation/resources/ui_assets.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/presentation/resources/colors.dart';
import '../../../core/presentation/widgets/clipper.dart';

class AuthInterceptorScreen extends StatelessWidget {
  const AuthInterceptorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseWidget(
        builder: (context, config, theme) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipPath(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: pasminaColor,
                  ),
                  child: Image.asset(
                    UIAssets.app_Icon,
                    width: config.appWidth(50),
                  ),
                ),
                clipper: Clipper(),
              ),
              config.verticalSpaceCustom(0.20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: config.appEdgePadding()),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrimaryButton(
                      color: theme.primaryColor,
                      label: "SIGN IN",
                      onPressed: () {
                        Get.toNamed(Routes.login);
                      },
                    ),
                    config.verticalSpaceMedium(),
                    Text("NEW CUSTOMER?", style: theme.textTheme.bodyText2),
                    config.verticalSpaceMedium(),
                    PrimaryOutlinedButton(
                      borderColor: theme.primaryColor,
                      title: 'REGISTER',
                      onPressed: () {
                        Get.toNamed(Routes.register);
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
