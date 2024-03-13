import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/resources/ui_assets.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/features/profile/data/model/response/user.dart';
import 'package:yeshelpinghand/features/profile/presentation/controller/profile_controller.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../auth/presentation/screen/register_screen.dart';
import '../../../auth/presentation/utils/customer_form_type_enum.dart';

class AccountDetailScreen extends StatelessWidget {
  const AccountDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Account Details"),
        ),
        body: BaseWidget(builder: (context, config, theme) {
          return SingleChildScrollView(
            child: GetBuilder<ProfileController>(builder: (controller) {
              final result = controller.userInfoResponse;
              if (result.hasData) {
                final user = result.data;
                return Column(
                  children: <Widget>[
                    _TopProfileSection(
                      user: user,
                    ),
                    config.verticalSpaceMedium(),
                    const _AccountDetailsView(),
                  ],
                );
              } else if (result.hasError) {
                return ErrorView(
                  title: NetworkException.getErrorMessage(result.error),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
          );
        }));
  }
}

class _AccountDetailsView extends StatelessWidget {
  const _AccountDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: config.appEdgePadding(), vertical: config.appHorizontalPadding(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              width: double.maxFinite,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: config.appHorizontalPadding(5),
                        vertical: config.appHorizontalPadding(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Additional Information",
                          style: theme.textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        config.verticalSpaceSmall(),
                        Text("Available membership Point : 0",
                            style: theme.textTheme.bodyText2?.copyWith(color: Colors.grey)),
                        config.verticalSpaceSmall(),
                        const Divider(),
                        config.verticalSpaceSmall(),
                        Text(
                          "News Letter",
                          style: theme.textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        config.verticalSpaceSmall(),
                        Text(
                          "You are subscribed to 'General Subscription' ",
                          style: theme.textTheme.bodyText2?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 30,
                        width: 30,
                        padding: EdgeInsets.only(
                          top: config.appVerticalPaddingSmall(),
                          right: config.appHorizontalPaddingMedium(),
                        ),
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.add,
                            size: 18,
                            color: theme.primaryColor.withOpacity(0.5),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(config.appWidth(0)),
                            side:
                                BorderSide(width: 2.0, color: theme.primaryColor.withOpacity(0.5)),
                            shape: const CircleBorder(),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            config.verticalSpaceMedium(),
            Container(
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              width: double.maxFinite,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: config.appHorizontalPadding(5),
                        vertical: config.appHorizontalPadding(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Default Billing Address",
                          style: theme.textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        config.verticalSpaceSmall(),
                        Text(
                          "Srijana Shrees",
                          style: theme.textTheme.bodyText2?.copyWith(color: Colors.grey),
                        ),
                        config.verticalSpaceSmall(),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: theme.primaryColor, size: 16),
                            Text(
                              "Lekhnath-27, Rithepani, Pokhara, 33700, Nepal ",
                              style: theme.textTheme.bodyText2?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                        config.verticalSpaceSmall(),
                        const Divider(),
                        config.verticalSpaceSmall(),
                        Text(
                          "Default Shipping Address",
                          style: theme.textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        config.verticalSpaceSmall(),
                        Text("No default Address",
                            style: theme.textTheme.bodyText2?.copyWith(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 30,
                        width: 30,
                        padding: EdgeInsets.only(
                          top: config.appVerticalPaddingSmall(),
                          right: config.appHorizontalPaddingMedium(),
                        ),
                        child: OutlinedButton(
                          onPressed: () {},
                          child: SvgPicture.asset(UIAssets.getSvg("circular_edit_icon.svg"),
                              color: theme.primaryColor.withOpacity(0.5)),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(config.appWidth(0)),
                            shape: const CircleBorder(),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _TopProfileSection extends StatelessWidget {
  const _TopProfileSection({
    required this.user,
    Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        SizedBox(
          height: 76,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(width: 3, color: theme.colorScheme.secondary),
                    ),
                    child: Text(
                      "${user.name?[0].toUpperCase()}",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  )),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.register,
                        arguments: CustomerFormParams(customerFormType: CustomerFormType.edit));
                  },
                  child: Container(
                    padding: EdgeInsets.all(config.appWidth(1.5)),
                    margin: EdgeInsets.only(right: config.appEdgePadding()),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                    child: SvgPicture.asset(UIAssets.editIcon, width: 28),
                  ),
                ),
              )
            ],
          ),
        ),
        Text(
          "${user.name} ",
          style: theme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
        ),
        config.verticalSpaceSmall(),
        Text(
          '${user.email}',
          style: theme.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.normal),
        ),
        config.verticalSpaceSmall(),
        Text(
          '${user.phoneNumber}',
          style: theme.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.normal),
        ),
        config.verticalSpaceMedium(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: config.appWidth(15), child: Divider()),
            config.horizontalSpaceSmall(),
            PrimaryTextButton(
              label: 'Update Password',
              onPressed: () {
                Get.toNamed(Routes.passwordUpdate);
              },
            ),
            config.horizontalSpaceSmall(),
            SizedBox(width: config.appWidth(15), child: Divider()),
          ],
        )
      ]);
    });
  }
}
