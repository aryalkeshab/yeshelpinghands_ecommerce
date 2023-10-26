import 'package:flutter/material.dart';
import 'package:yeshelpinghand/core/presentation/resources/colors.dart';
import '../../../../../core/presentation/widgets/base_widget.dart';
import '../../../../../core/presentation/widgets/buttons.dart';
import '../../../../address/data/model/response/address.dart';

class CheckoutAddressInformationLayout extends StatelessWidget {
  final Address? address;
  final String title;
  final VoidCallback onChooseAnotherPressed;

  const CheckoutAddressInformationLayout({
    Key? key,
    this.address,
    required this.title,
    required this.onChooseAnotherPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      final _addressItemSpacing = config.verticalSpaceSmall();
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: config.appEdgePadding(),
            vertical: config.appVerticalPaddingMedium()),
        decoration: BoxDecoration(
            color: kWhite400, borderRadius: BorderRadius.circular(10)),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(title,
                    style: theme.textTheme.bodyText1
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            config.verticalSpaceSmall(),
            Text(
              '${address?.city}',
              // '${address?.city} ${address?.lastName}',
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
                  '${address?.country}, ${address?.city}, ${address?.postalCode}, ${address?.address}',
                ),
              ],
            ),
            config.verticalSpaceMedium(),
            Align(
              alignment: Alignment.centerRight,
              child: PrimaryTextButton(
                  onPressed: onChooseAnotherPressed, label: "Change"),
            ),
          ],
        ),
      );
    });
  }
}

class _AddressItemLayout extends StatelessWidget {
  final String label;
  final String value;

  const _AddressItemLayout({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
          ),
          config.horizontalSpaceMedium(),
          Text(value, style: theme.textTheme.bodyText1)
        ],
      );
    });
  }
}
