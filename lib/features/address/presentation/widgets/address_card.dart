import 'package:get/get.dart';
import 'package:yeshelpinghand/features/address/presentation/utils/address_type_enum.dart';
import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/base_widget.dart';
import '../../../../core/presentation/widgets/buttons.dart';
import '../../../shared/layouts/confirm_dialog_view.dart';
import '../../data/model/response/address.dart';
import '../controller/address_controller.dart';
import 'address_bottom_modal_sheet.dart';

class AddressCard extends StatelessWidget {
  final bool isSelected;
  // final bool isSelectable;
  final Function(Address) onPressed;
  final Address address;
  // final AddressType? addressType;

  const AddressCard({
    Key? key,
    // required this.isSelectable,
    required this.address,
    required this.onPressed,
    // this.addressType,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              // onTap: isSelectable
              //     ? () {
              //         onPressed(address);
              //       }
              //     : null,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: config.appEdgePadding(),
                    vertical: config.appVerticalPaddingMedium()),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${address.address}',
                          style: theme.textTheme.bodyText2
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        config.verticalSpaceSmall(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Theme.of(context).primaryColor,
                                size: 16),
                            config.horizontalSpaceSmall(),
                            Text(
                              '${address.country}, ${address.city},\n${address.postalCode},',
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return ConfirmDialogView(
                                primaryText:
                                    "Are you sure you want to delete this address?",
                                onApproveButtonPressed: () {
                                  Get.back();
                                  Get.find<AddressController>()
                                      .deleteAddress(context, "${address.id}");
                                },
                                onCancelButtonPressed: Get.back,
                              );
                            },
                          );
                          // Get.find<AddressController>()
                          //     .deleteAddress(context, address.id.toString());
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
