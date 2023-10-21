import 'package:flutter/material.dart';
import 'package:yeshelpinghand/core/utils/constants.dart';

import '../../../../core/presentation/widgets/base_widget.dart';
import '../../../../core/utils/number_parser.dart';
import '../../data/response/order_details.dart';

class OrderDetailItemCard extends StatelessWidget {
  const OrderDetailItemCard({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  final OrderItem? orderItem;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Container(
        padding: EdgeInsets.all(config.appVerticalPaddingSmall()),
        margin: EdgeInsets.only(bottom: config.appVerticalPaddingMedium()),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${orderItem?.name}"),
            config.verticalSpaceMedium(),
            Row(
              children: [
                Text(
                  "$currency ${NumberParser.twoDecimalDigit(orderItem?.price.toString())}",
                ),
                config.horizontalSpaceLarge(),
                // Text.rich(
                //   TextSpan(children: [
                //     TextSpan(
                //       text: "SKU : ",
                //       style: theme.textTheme.bodyText2
                //           ?.copyWith(color: Colors.grey),
                //     ),
                //     TextSpan(text: "${orderItem?.sku}"),
                //   ]),
                // ),
              ],
            ),
            config.verticalSpaceMedium(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: "Qty. : ",
                      style: theme.textTheme.bodyText2
                          ?.copyWith(color: Colors.grey),
                    ),
                    TextSpan(text: "${orderItem?.quantity}"),
                  ]),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
