import 'package:yeshelpinghand/core/presentation/resources/colors.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/core/presentation/widgets/textfields.dart';
import 'package:yeshelpinghand/core/utils/custom_validators.dart';
import 'package:yeshelpinghand/features/auth/presentation/controller/password_reset_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/resources/ui_assets.dart';
import '../../../../core/presentation/widgets/clipper.dart';

class PasswordResetScreen extends StatelessWidget {
  PasswordResetScreen({Key? key}) : super(key: key);
  late String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: HookBaseWidget(builder: (context, config, theme) {
          final resetPasswordFormKey = useMemoized(() => GlobalKey<FormState>());
          return Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.45,
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
                  Positioned(
                    top: 30,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: Get.back,
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: config.appEdgePadding()),
                child: Center(
                  child: Form(
                    key: resetPasswordFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // const Circularapp_Icon(),
                        config.verticalSpaceMedium(),
                        Text("Forgot your password?", style: theme.textTheme.headline6),
                        config.verticalSpaceSmall(),
                        const Text("Please enter your email address.", textAlign: TextAlign.center),
                        config.verticalSpaceLarge(),
                        PrimaryFormField(
                          hintIcon: Icon(
                            Icons.email,
                            color: theme.primaryColor,
                          ),
                          label: '${"Email".tr}',
                          isRequired: true,
                          validator: (value) => Validator.validateEmail(value!),
                          onSaved: (value) {
                            email = value;
                          },
                        ),
                        config.verticalSpaceLarge(),
                        PrimaryButton(
                            label: "RESET MY PASSWORD",
                            onPressed: () {
                              if (resetPasswordFormKey.currentState?.validate() == true) {
                                resetPasswordFormKey.currentState?.save();
                                Get.find<PasswordResetController>().resetPassword(context, email);
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
