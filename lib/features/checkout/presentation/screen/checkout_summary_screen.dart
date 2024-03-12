import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/presentation/widgets/cached_network_image_builder.dart';
import 'package:yeshelpinghand/core/utils/constants.dart';
import 'package:yeshelpinghand/features/address/data/model/response/address.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/confirm_order_params.dart';
import 'package:yeshelpinghand/features/checkout/presentation/controller/order_summary_controller.dart';
import 'package:yeshelpinghand/features/checkout/presentation/screen/widgets/checkout_stepper.dart';

import '../../../../core/presentation/widgets/base_widget.dart';
import '../../../../core/utils/number_parser.dart';

class CheckoutSummaryScreen extends StatelessWidget {
  final ConfirmOrderParams confirmOrderParams;

  const CheckoutSummaryScreen({Key? key, required this.confirmOrderParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckoutStepper(
      currentStep: 3,
      onProceed: () {
        Get.put(OrderSummaryController()).placeOrder(context, confirmOrderParams);
      },
      child: Builder(builder: (context) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BaseWidget(builder: (context, config, theme) {
            return Column(
              children: [
                _OrdersSummary(orderSummary: confirmOrderParams),
                config.verticalSpaceVerySmall(),
                _AddressSummaryView(confirmOrderParams: confirmOrderParams),
                config.verticalSpaceMedium(),
              ],
            );
          }),
        );
      }),
    );
  }
}

class _AddressSummaryView extends StatelessWidget {
  const _AddressSummaryView({
    Key? key,
    required this.confirmOrderParams,
  }) : super(key: key);

  final ConfirmOrderParams confirmOrderParams;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(
          config.appEdgePadding(),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Address Summary',
              style: theme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
            ),
            config.verticalSpaceSmall(),
            _AddressSummaryCard(
                title: "Shipping Address", address: confirmOrderParams.shippingAddress),
            config.verticalSpaceMedium(),
            _AddressSummaryCard(
                title: "Billing Address", address: confirmOrderParams.billingAddress),
          ],
        ),
      );
    });
  }
}

class _AddressSummaryCard extends StatelessWidget {
  const _AddressSummaryCard({
    Key? key,
    required this.address,
    this.title,
  }) : super(key: key);

  final Address? address;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.3, color: theme.focusColor)),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Text(
                "$title",
                style: theme.textTheme.caption?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            config.verticalSpaceSmall(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor, size: 24),
                config.horizontalSpaceSmall(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${address?.country}, ${address?.city}, ${address?.postalCode}, ${address?.address}',
                    ),
                    config.verticalSpaceSmall(),
                    Text("To: ${address?.city} ${address?.address}",
                        style: theme.textTheme.caption),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _OrdersSummary extends StatelessWidget {
  const _OrdersSummary({
    Key? key,
    required this.orderSummary,
  }) : super(key: key);

  final ConfirmOrderParams orderSummary;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(config.appEdgePadding()),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your Orders',
                style: theme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600)),
            config.verticalSpaceSmall(),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(orderSummary.cartDetail?.length ?? 0, (index) {
                  final orderItem = orderSummary.cartDetail![index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: config.appVerticalPaddingMedium()),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.3, color: theme.focusColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              child: CustomCachedNetworkImage(
                                isCompleteUrl: false,
                                "${orderItem.image}",
                                fit: BoxFit.fill,
                              ),
                              width: 80,
                            ),
                            config.horizontalSpaceMedium(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('${orderItem.name}'),
                                  config.verticalSpaceSmall(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Quantity: ${orderItem.qty}',
                                          style: theme.textTheme.caption),
                                      Text(
                                          "$currency ${NumberParser.twoDecimalDigit(orderItem.price.toString())}",
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
            config.verticalSpaceSmall(),
            const Divider(),
            config.verticalSpaceSmall(),
            // Text(
            //     'SubTotal: $currency ${NumberParser.twoDecimalDigit(orderSummary.subtotal.toString())}'),
            // config.verticalSpaceSmall(),
            // Text(
            //     'Shipping Fee: $currency ${NumberParser.twoDecimalDigit(orderSummary.shippingAmount.toString())}'),
            // config.verticalSpaceSmall(),
            // Text(
            //     'Total: $currency ${NumberParser.twoDecimalDigit(orderSummary.grandTotal.toString())}',
            //     style: theme.textTheme.bodyText1
            // ?.copyWith(fontWeight: FontWeight.w600)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SubTotal: $currency ${orderSummary.cartResponse?.total?.subTotal.toString()}',
                ),
                config.verticalSpaceSmall(),
                Text(
                  'Shipping Fee: $currency ${orderSummary.cartResponse?.total?.shipping.toString()}',
                ),
                config.verticalSpaceSmall(),
              ],
            ),
            config.verticalSpaceSmall(),

            Text('Total: $currency ${orderSummary.cartResponse?.total?.grandTotal.toString()}',
                style: theme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600)),
            config.verticalSpaceSmall(),
            // Container(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: config.appVerticalPaddingSmall(),
            //       vertical: config.appVerticalPaddingSmall(),
            //     ),
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //           color: Theme.of(context).colorScheme.secondary),
            //     ),
            //     child: Text('${orderSummary}')),
            // config.verticalSpaceMedium(),
            RichText(
                text: TextSpan(children: [
              TextSpan(text: "Payment Method: ", style: theme.textTheme.bodyText2),
              TextSpan(
                  text: "${orderSummary.paymentMethod}",
                  style: theme.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w500)),
            ])),
          ],
        ),
      );
    });
  }
}
