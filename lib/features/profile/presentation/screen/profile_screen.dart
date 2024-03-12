import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yeshelpinghand/core/presentation/resources/ui_assets.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/features/address/presentation/utils/address_book_type_enum.dart';
import 'package:yeshelpinghand/features/auth/presentation/screen/register_screen.dart';
import 'package:yeshelpinghand/features/auth/presentation/utils/customer_form_type_enum.dart';
import 'package:yeshelpinghand/features/profile/presentation/controller/profile_controller.dart';
import 'package:yeshelpinghand/features/shared/layouts/auth_widget_wrapper.dart';
import 'package:yeshelpinghand/features/shared/layouts/confirm_dialog_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../auth/presentation/controller/auth_controller.dart';
import '../../../shared/layouts/error_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('My Account'),
        ),
        body: GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (controller) {
              return SmartRefresher(
                  controller: controller.refreshController,
                  enablePullUp: false,
                  enablePullDown: true,
                  header: const WaterDropHeader(),
                  onRefresh: () => controller.getUserInfoResponse(),
                  child: BaseWidget(builder: (context, config, theme) {
                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const _TopSectionView(),
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25))),
                            child: Column(children: [
                              _ProfileMenuItem(
                                leadingIcon: Icons.book_outlined,
                                title: 'Address Book',
                                onTap: () {
                                  Get.toNamed(Routes.addressList,
                                      arguments: AddressBookType.nonSelectable);
                                },
                              ),
                              _ProfileMenuItem(
                                leadingIcon: Icons.history,
                                title: "Order History",
                                onTap: () {
                                  Get.toNamed(Routes.orderHistory);
                                },
                              ),
                              _ProfileMenuItem(
                                title: "Privacy and Cookie Policy",
                                leadingIcon: CupertinoIcons.doc_on_doc,
                                onTap: () {
                                  Get.toNamed(Routes.privacyPolicy);
                                },
                              ),
                              _ProfileMenuItem(
                                title: "About Us",
                                leadingIcon: CupertinoIcons.info,
                                onTap: () {
                                  Get.toNamed(Routes.aboutUs);
                                },
                              ),
                              _ProfileMenuItem(
                                title: "Contact Us",
                                leadingIcon: CupertinoIcons.phone,
                                onTap: () {
                                  Get.toNamed(Routes.contactUs);
                                },
                              ),
                              AuthWidgetBuilder(
                                builder: (context, isAuthenticated) {
                                  if (isAuthenticated) {
                                    return _ProfileMenuItem(
                                      leadingIcon: Icons.logout,
                                      title: 'Logout',
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return ConfirmDialogView(
                                              primaryText: "Are you sure you want to logout?",
                                              onApproveButtonPressed: () {
                                                Get.find<AuthController>().logout();
                                                Get.until((route) {
                                                  return route.settings.name == Routes.dashboard;
                                                });
                                              },
                                              onCancelButtonPressed: Get.back,
                                            );
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    return _ProfileMenuItem(
                                      leadingIcon: Icons.login,
                                      title: 'Login',
                                      onTap: () {
                                        Get.toNamed(Routes.login);
                                      },
                                    );
                                  }
                                },
                              ),
                            ]),
                          )
                        ],
                      ),
                    );
                  }));
            }));
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final VoidCallback onTap;
  final IconData leadingIcon;
  final String title;

  const _ProfileMenuItem(
      {Key? key, required this.onTap, required this.leadingIcon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        leading: Icon(leadingIcon),
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ));
  }
}

class _TopSectionView extends StatelessWidget {
  const _TopSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: config.appHorizontalPaddingMedium(),
        ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: config.appEdgePadding(),
              vertical: config.appVerticalPaddingMedium(),
            ),
            child: GetBuilder<ProfileController>(
                init: ProfileController(),
                builder: (controller) {
                  final result = Get.find<ProfileController>().userInfoResponse;
                  if (result.hasData) {
                    final user = result.data;

                    return Column(children: <Widget>[
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 2, color: theme.primaryColor),
                                ),
                                child: Text(
                                  "${user.name?[0].toUpperCase()}",
                                  style: theme.textTheme.bodyText1?.copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: theme.scaffoldBackgroundColor),
                                ),
                              )),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.register,
                                      arguments: CustomerFormParams(
                                          customerFormType: CustomerFormType.edit));
                                },
                                child: SvgPicture.asset(
                                  UIAssets.editIcon,
                                  width: 28,
                                ),
                              ))
                        ],
                      ),
                      Text(
                        "${user.name} ",
                        style: theme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      config.verticalSpaceSmall(),
                      Text(
                        "${user.email}",
                      ),
                      config.verticalSpaceSmall(),
                      if (user.phoneNumber?.isNotEmpty == true)
                        Text(
                          '${user.phoneNumber}',
                          style: theme.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.normal),
                        ),
                    ]);
                  } else if (result.hasError) {
                    return ErrorView(
                      title: NetworkException.getErrorMessage(result.error),
                    );
                  } else {
                    return const _LoadingProfileView();
                  }
                }),
          ),
        ),
      );
      //     }),
      //   );
    });
  }
}

class _LoadingProfileView extends StatelessWidget {
  const _LoadingProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            children: [
              ShimmerWidget.circular(radius: 30),
            ],
          ),
          config.verticalSpaceSmall(),
          ShimmerWidget.rounded(width: config.appWidth(35), height: 15),
          config.verticalSpaceSmall(),
          ShimmerWidget.rounded(width: config.appWidth(30), height: 12),
          config.verticalSpaceSmall(),
        ],
      );
    });
  }
}
