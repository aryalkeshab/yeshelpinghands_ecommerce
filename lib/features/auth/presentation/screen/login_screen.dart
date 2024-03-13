import 'package:yeshelpinghand/core/presentation/resources/colors.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/core/presentation/widgets/focus_node_disabler.dart';
import 'package:yeshelpinghand/core/presentation/widgets/textfields.dart';
import 'package:yeshelpinghand/core/utils/custom_validators.dart';
import 'package:yeshelpinghand/features/auth/data/models/request/login_params.dart';
import 'package:yeshelpinghand/features/auth/presentation/controller/login_controller.dart';
import 'package:yeshelpinghand/features/auth/presentation/screen/register_screen.dart';
import 'package:yeshelpinghand/features/auth/presentation/utils/customer_form_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import '../../../../core/presentation/resources/ui_assets.dart';
import '../../../../core/presentation/widgets/clipper.dart';

class LoginScreen extends StatelessWidget {
  final bool? showLeading;

  const LoginScreen({
    Key? key,
    this.showLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FocusNodeDisabler(
        child: BaseWidget(builder: (context, config, theme) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
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
                LoginFormBuilder(),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class LoginFormBuilder extends StatelessWidget {
  LoginFormBuilder({
    Key? key,
  }) : super(key: key);

  final LoginParams loginParams = LoginParams();

  @override
  Widget build(BuildContext context) {
    return HookBaseWidget(
      builder: (context, config, theme) {
        final _loginFormKey = useMemoized(GlobalKey<FormState>.new);
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border.all(width: 0.5, color: Colors.grey.shade200)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _loginFormKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: config.appEdgePadding(),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PrimaryFormField(
                      hintIcon: Icon(
                        Icons.email,
                        size: 25,
                        color: theme.primaryColor,
                      ),
                      label: "Email".tr,
                      isRequired: true,
                      validator: (value) => Validator.validateEmail(value!),
                      onSaved: (value) {
                        loginParams.email = value;
                      },
                    ),
                    config.verticalSpaceMedium(),
                    PrimaryFormField(
                      isPassword: true,
                      hintIcon: Icon(
                        Icons.lock,
                        color: theme.primaryColor,
                        size: 25,
                      ),
                      isRequired: true,
                      label: "Password".tr,
                      validator: (value) => Validator.validateEmpty(value!),
                      onSaved: (value) {
                        loginParams.password = value;
                      },
                    ),
                    config.verticalSpaceMedium(),
                    Align(
                      alignment: Alignment.topRight,
                      child: PrimaryTextButton(
                        isSmallButton: true,
                        labelColor: theme.primaryColor,
                        label: 'Forgot Your Password ?',
                        onPressed: () {
                          Get.toNamed(Routes.passwordReset);
                        },
                      ),
                    ),
                    config.verticalSpaceLarge(),
                    PrimaryButton(
                        label: "SIGN IN",
                        onPressed: () {
                          final currentState = _loginFormKey.currentState;
                          if (currentState != null) {
                            currentState.save();

                            if (currentState.validate()) {
                              Get.find<LoginController>().requestLogin(loginParams, context);
                            }
                          }
                        }),
                    config.verticalSpaceLarge(),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.register,
                            arguments:
                                CustomerFormParams(customerFormType: CustomerFormType.create));
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'NEW CUSTOMER ? ',
                                style: theme.textTheme.bodyText2
                                    ?.copyWith(color: theme.textTheme.caption?.color),
                              ),
                              TextSpan(
                                text: 'START HERE',
                                style: theme.textTheme.bodyText2?.copyWith(
                                    color: theme.primaryColor, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
