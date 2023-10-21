import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/core/presentation/widgets/focus_node_disabler.dart';
import 'package:yeshelpinghand/core/presentation/widgets/textfields.dart';
import 'package:yeshelpinghand/core/utils/custom_validators.dart';
import 'package:yeshelpinghand/features/auth/data/models/request/register_params.dart';
import 'package:yeshelpinghand/features/auth/presentation/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/features/profile/data/model/response/user.dart';

import '../../../../core/presentation/resources/colors.dart';
import '../../../../core/presentation/resources/ui_assets.dart';
import '../../../../core/presentation/widgets/clipper.dart';
import '../../../profile/presentation/controller/profile_controller.dart';
import '../utils/customer_form_type_enum.dart';

class CustomerFormParams {
  CustomerFormType customerFormType;

  CustomerFormParams({this.customerFormType = CustomerFormType.create});
}

class RegisterScreen extends StatelessWidget {
  final CustomerFormParams customerFormParams;

  const RegisterScreen({required this.customerFormParams, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pasminaColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: Get.back,
        ),
      ),
      body: BaseWidget(builder: (context, config, theme) {
        return FocusNodeDisabler(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: ClipPath(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    color: pasminaColor,
                    child: Image.asset(
                      UIAssets.app_Icon,
                      width: config.appWidth(50),
                    ),
                  ),
                  clipper: Clipper(),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: RegisterFormBuilder(
                      customerFormParams: customerFormParams)),
            ],
          ),
        );
      }),
    );
  }
}

class RegisterFormBuilder extends StatelessWidget {
  final CustomerFormParams customerFormParams;

  RegisterFormBuilder({
    required this.customerFormParams,
    Key? key,
  }) : super(key: key);

  final RegisterParams registerParams = RegisterParams();

  @override
  Widget build(BuildContext context) {
    return HookBaseWidget(builder: (context, config, theme) {
      final registerFormKey = useMemoized(GlobalKey<FormState>.new);
      return Form(
        key: registerFormKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: config.appVerticalPaddingLarge(),
              left: config.appEdgePadding(),
              right: config.appEdgePadding(),
            ),
            child: GetBuilder<ProfileController>(
                init: ProfileController(),
                builder: (profileController) {
                  final result = Get.find<ProfileController>().userInfoResponse;
                  final user = result.data;
                  // print(
                  //     "this is printed from register screen --${result.data}");
                  return Column(
                    children: [
                      config.verticalSpaceMedium(),
                      PrimaryFormField(
                        initialValue: user?.firstname ?? "",
                        hintIcon: _buildFormFieldIcon(
                          Icons.person_outline,
                          theme.primaryColor,
                        ),
                        label: '${"Name".tr}',
                        isRequired: true,
                        validator: (value) => Validator.validateEmpty(value!),
                        onSaved: (value) {
                          registerParams.name = value;
                        },
                      ),
                      config.verticalSpaceMedium(),
                      PrimaryFormField(
                        initialValue: user?.lastname ?? '',
                        hintIcon: _buildFormFieldIcon(
                            Icons.person_outline, theme.primaryColor),
                        validator: (value) => Validator.validateEmpty(value!),
                        label: '${"Username".tr} ',
                        isRequired: true,
                        onSaved: (value) {
                          registerParams.username = value;
                        },
                      ),
                      config.verticalSpaceMedium(),
                      customerFormParams.customerFormType ==
                              CustomerFormType.create
                          ? Column(
                              children: [
                                PrimaryFormField(
                                  hintIcon: _buildFormFieldIcon(
                                      Icons.mail, theme.primaryColor),
                                  label: '${"Email".tr} ',
                                  isRequired: true,
                                  validator: (value) =>
                                      Validator.validateEmail(value!),
                                  onSaved: (value) {
                                    registerParams.email = value;
                                  },
                                ),
                                config.verticalSpaceMedium(),
                                PrimaryFormField(
                                  hintIcon: _buildFormFieldIcon(
                                      Icons.lock, theme.primaryColor),
                                  isPassword: true,
                                  validator: (value) =>
                                      Validator.validatePassword(value!),
                                  label: '${"Password".tr} ',
                                  isRequired: true,
                                  onSaved: (value) {
                                    registerParams.password = value;
                                  },
                                  onChanged: (value) {
                                    registerParams.password = value;
                                  },
                                ),
                                config.verticalSpaceMedium(),
                                PrimaryFormField(
                                  hintIcon: _buildFormFieldIcon(
                                      Icons.lock, theme.primaryColor),
                                  isPassword: true,
                                  label: '${"Confirm Password".tr} ',
                                  isRequired: true,
                                  validator: (value) {
                                    print("confirmPassword:$value");
                                    print(
                                        "password:${registerParams.password}");
                                    if (value?.isEmpty == true)
                                      return "This field is required";
                                    else if (registerParams.confirmPassword !=
                                        registerParams.password)
                                      return "Password and confirm password don't match";
                                    return null;
                                  },
                                  onSaved: (value) {
                                    registerParams.confirmPassword = value;
                                  },
                                  onChanged: (value) {
                                    registerParams.confirmPassword = value;
                                  },
                                ),
                                config.verticalSpaceMedium(),
                              ],
                            )
                          : const SizedBox(),
                      PrimaryFormField(
                        initialValue: user?.phoneNumber ?? '',
                        hintIcon: _buildFormFieldIcon(
                            Icons.phone_android, theme.primaryColor),
                        keyboardType: TextInputType.phone,
                        validator: (value) => Validator.validateMobile(value!),
                        label: '${"Phone Number".tr}',
                        isRequired: true,
                        onSaved: (value) {
                          registerParams.contactNumber = value;
                        },
                      ),
                      config.verticalSpaceLarge(),
                      PrimaryButton(
                          label: customerFormParams.customerFormType ==
                                  CustomerFormType.create
                              ? "CREATE AN ACCOUNT"
                              : "UPDATE",
                          onPressed: () {
                            registerFormKey.currentState?.save();

                            if (registerFormKey.currentState?.validate() ==
                                true) {
                              customerFormParams.customerFormType ==
                                      CustomerFormType.create
                                  ? Get.find<RegisterController>()
                                      .requestRegister(registerParams, context)
                                  : Get.find<ProfileController>()
                                      .updateCustomerInfo(
                                          context, registerParams);
                            }
                          }),
                    ],
                  );
                }),
          ),
        ),
      );
    });
  }

  Icon _buildFormFieldIcon(IconData iconData, color) {
    return Icon(
      iconData,
      color: color,
      size: 25,
    );
  }
}
