import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:yeshelpinghand/core/utils/string_capitalize.dart';
import '../../../../core/presentation/widgets/base_widget.dart';
import '../../../shared/layouts/confirm_dialog_view.dart';
import '../../data/model/response/address.dart';
import '../controller/address_controller.dart';

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
      return Padding(
        padding: EdgeInsets.symmetric(vertical: config.appVerticalPaddingSmall()),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 0.3,
                  color: theme.disabledColor,
                  strokeAlign: BorderSide.strokeAlignOutside)),
          child: ListTile(
            title: Text(
              StringCapitalize.capitalizeSentence(address.address ?? 'address'),
              style: theme.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            subtitle: Container(
              padding: EdgeInsets.symmetric(vertical: config.appVerticalPaddingSmall()),
              width: double.maxFinite,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor, size: 26),
                  config.horizontalSpaceSmall(),
                  Text(
                    '${StringCapitalize.capitalizeSentence(address.country ?? 'country')}, ${StringCapitalize.capitalizeSentence(address.city ?? 'city')},\n${address.postalCode},',
                    style: theme.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            trailing: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return ConfirmDialogView(
                        primaryText: "Are you sure you want to delete this address?",
                        onApproveButtonPressed: () {
                          Get.back();
                          Get.find<AddressController>().deleteAddress(context, "${address.id}");
                        },
                        onCancelButtonPressed: Get.back,
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ),
        ),
      );
    });
  }
}
