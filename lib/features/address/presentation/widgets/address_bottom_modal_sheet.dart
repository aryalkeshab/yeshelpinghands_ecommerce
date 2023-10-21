import 'package:yeshelpinghand/features/address/presentation/utils/address_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/resources/ui_assets.dart';
import '../../../../core/presentation/routes/app_pages.dart';
import '../../../../core/presentation/widgets/base_widget.dart';
import '../../../../core/utils/size_config.dart';
import '../../../shared/layouts/confirm_dialog_view.dart';
import '../../data/model/response/address.dart';
import '../add_address_screen.dart';
import '../controller/address_controller.dart';
import '../utils/address_form_type_enum.dart';
import 'warning_message.dart';

class AddressBottomModalSheet extends StatelessWidget {
  final Address address;
  final AddressType? addressType;
  final BuildContext buildContext;

  const AddressBottomModalSheet({
    Key? key,
    this.addressType,
    required this.address,
    required this.buildContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (ctx, config, theme) {
      final _menuItemSpacing = config.verticalSpaceSmall();
      return Container(
        height: config.appHeight(28),
        margin: EdgeInsets.symmetric(
            horizontal: config.appEdgePadding(),
            vertical: config.appVerticalPaddingLarge()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (addressType == null ||
                (addressType == AddressType.billing &&
                    !Get.find<AddressController>()
                        .isDefaultShippingAndBillingSame))
              _BottomModalMenuItem(
                title: "Set as default shipping address",
                icon: Icons.home_filled,
                onTap: () {
                  Get.back();
                  Get.find<AddressController>()
                      .setDefaultShippingAddress(buildContext, "${address.id}");
                },
              ),
            _menuItemSpacing,
            if (addressType == null ||
                (addressType == AddressType.shipping &&
                    !Get.find<AddressController>()
                        .isDefaultShippingAndBillingSame))
              _BottomModalMenuItem(
                title: "Set as default billing address",
                icon: Icons.monetization_on,
                onTap: () {
                  Get.back();
                  Get.find<AddressController>()
                      .setDefaultBillingAddress(buildContext, "${address.id}");
                },
              ),
            _menuItemSpacing,
            const Divider(),
            _menuItemSpacing,
            if (addressType == null)
              _BottomModalMenuItem(
                title: "Remove address",
                icon: Icons.delete_outline,
                onTap: () {
                  Get.back();
                  showDialog(
                    context: buildContext,
                    builder: (ctx) {
                      return ConfirmDialogView(
                        primaryText:
                            "Are you sure you want to delete this address?",
                        onApproveButtonPressed: () {
                          Get.back();
                          Get.find<AddressController>()
                              .deleteAddress(buildContext, "${address.id}");
                        },
                        onCancelButtonPressed: Get.back,
                      );
                    },
                  );
                },
              ),
            _menuItemSpacing,
            _BottomModalMenuItem(
              title: "Edit address",
              subTitle: addressType != null &&
                      Get.find<AddressController>()
                          .isDefaultShippingAndBillingSame
                  ? "Default shipping and billing address are same. Updating one shall update the other"
                  : null,
              icon: UIAssets.circularEditIcon,
              onTap: () {
                Get
                  ..back()
                  ..toNamed(Routes.addAddress,
                      arguments: AddressFormParams(
                        addressFormType: AddressFormType.edit,
                        address: address,
                        addressType: addressType ?? AddressType.others,
                      ));
              },
            ),
          ],
        ),
      );
    });
  }
}

class _BottomModalMenuItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final dynamic icon;
  final VoidCallback onTap;

  const _BottomModalMenuItem({
    Key? key,
    required this.onTap,
    required this.icon,
    this.subTitle,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _config = SizeConfig(context);
    return InkWell(
      onTap: onTap,
      child: Container(
          // color: Colors.transparent,
          padding:
              EdgeInsets.symmetric(vertical: _config.appVerticalPaddingSmall()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  icon.runtimeType == String
                      ? SvgPicture.asset(
                          icon,
                          color: Theme.of(context).primaryColor,
                          width: 20,
                        )
                      : Icon(icon, color: Theme.of(context).primaryColor),
                  _config.horizontalSpaceSmall(),
                  Text(title),
                ],
              ),
              if (subTitle != null) _config.verticalSpaceSmall(),
              if (subTitle != null) WarningMessage(subTitle!),
            ],
          )),
    );
  }
}
