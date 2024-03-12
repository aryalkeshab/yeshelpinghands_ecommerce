import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/core/presentation/widgets/textfields.dart';
import 'package:yeshelpinghand/core/utils/custom_validators.dart';
import 'package:yeshelpinghand/features/auth/data/models/request/update_password_params.dart';
import 'package:yeshelpinghand/features/auth/presentation/controller/password_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import '../../../../core/presentation/resources/colors.dart';
import '../../../../core/presentation/resources/ui_assets.dart';
import '../../../../core/presentation/widgets/clipper.dart';

class PasswordUpdateScreen extends StatefulWidget {
  const PasswordUpdateScreen({Key? key}) : super(key: key);

  @override
  State<PasswordUpdateScreen> createState() => _PasswordUpdateScreenState();
}

class _PasswordUpdateScreenState extends State<PasswordUpdateScreen> {
  final UpdatePasswordParams updatePasswordParams = UpdatePasswordParams();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: HookBaseWidget(builder: (context, config, theme) {
          final passwordChangeFormKey = useMemoized(GlobalKey<FormState>.new);
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      config.verticalSpaceLarge(),
                      Form(
                        key: passwordChangeFormKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PrimaryFormField(
                              hintIcon: Icon(Icons.lock, color: theme.primaryColor),
                              isPassword: true,
                              validator: (value) => Validator.validateEmpty(value!),
                              label: '${" Current password".tr}',
                              isRequired: true,
                              onSaved: (value) {
                                updatePasswordParams.currentPassword = value;
                              },
                            ),
                            config.verticalSpaceMedium(),
                            PrimaryFormField(
                              hintIcon: Icon(Icons.lock, color: theme.primaryColor),
                              isPassword: true,
                              validator: (value) => Validator.validatePassword(value!),
                              label: '${" New password".tr}',
                              isRequired: true,
                              onChanged: (value) {
                                updatePasswordParams.newPassword = value;
                              },
                              onSaved: (value) {
                                updatePasswordParams.newPassword = value;
                              },
                            ),
                            config.verticalSpaceMedium(),
                            PrimaryFormField(
                              onSaved: (value) {},
                              hintIcon: Icon(Icons.lock, color: theme.primaryColor),
                              isPassword: true,
                              label: '${"Confirm password".tr}',
                              isRequired: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Confirm password is required";
                                } else if (value != updatePasswordParams.newPassword) {
                                  return "Password and confirm password didn't match";
                                }
                                return null;
                              },
                            ),
                            config.verticalSpaceLarge(),
                            PrimaryButton(
                                label: "Update",
                                onPressed: () {
                                  passwordChangeFormKey.currentState!.save();
                                  if (passwordChangeFormKey.currentState?.validate() == true) {
                                    Get.find<PasswordUpdateController>()
                                        .updatePassword(context, updatePasswordParams);
                                  }
                                }),
                          ],
                        ),
                      ),
                    ],
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
