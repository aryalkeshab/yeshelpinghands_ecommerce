import 'package:yeshelpinghand/features/address/presentation/utils/address_type_enum.dart';
import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/base_widget.dart';
import '../../data/model/response/address.dart';
import 'address_bottom_modal_sheet.dart';

class AddressCard extends StatelessWidget {
  final bool isSelected;
  final bool isSelectable;
  final Function(Address) onPressed;
  final Address address;
  final AddressType? addressType;

  const AddressCard({
    Key? key,
    required this.isSelectable,
    required this.address,
    required this.onPressed,
    this.addressType,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: isSelectable
                ? () {
                    onPressed(address);
                  }
                : null,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: config.appEdgePadding(),
                  vertical: config.appVerticalPaddingMedium()),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${address.firstName} ${address.lastName}',
                        style: theme.textTheme.bodyText2
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      config.verticalSpaceSmall(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: Theme.of(context).primaryColor, size: 16),
                          config.horizontalSpaceSmall(),
                          Text(
                            '${address.street}, ${address.city},\n${address.postalCode}, ${address.province}, ${address.country?.name}',
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          context: context,
                          builder: (ctx) {
                            return AddressBottomModalSheet(
                              addressType: addressType,
                              address: address,
                              buildContext: context,
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: theme.primaryColor,
                      )),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
