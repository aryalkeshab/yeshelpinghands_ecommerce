import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/resources/colors.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/core/utils/date_formatter_utils.dart';
import 'package:yeshelpinghand/core/utils/constants.dart';
import 'package:yeshelpinghand/features/address/data/model/response/address.dart';
import 'package:yeshelpinghand/features/order/presentation/controller/order_history_controller.dart';
import 'package:yeshelpinghand/features/order/presentation/utils/order_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/features/order/presentation/widgets/order_detail_item_card.dart';
import '../../../core/utils/number_parser.dart';
import '../../shared/layouts/error_view.dart';
import '../data/response/order_details.dart';

class OrderHistoryDetailsScreen extends StatefulWidget {
  final String orderNo;

  const OrderHistoryDetailsScreen({Key? key, required this.orderNo})
      : super(key: key);

  @override
  State<OrderHistoryDetailsScreen> createState() =>
      _OrderHistoryDetailsScreenState();
}

class _OrderHistoryDetailsScreenState extends State<OrderHistoryDetailsScreen> {
  final controller = Get.put(OrderHistoryController());

  @override
  void initState() {
    Future.microtask(() => controller.fetchOrderHistoryDetails(widget.orderNo));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderHistoryController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Order No. : ${controller.orderIncrementId ?? ''}"),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BaseWidget(
              builder: (context, config, theme) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: config.appEdgePadding(),
                      vertical: config.appVerticalPaddingMedium()),
                  child: Builder(
                    builder: (context) {
                      final result = controller.orderHistoryDetailsResponse;
                      if (result.hasData) {
                        final OrderDetails orderHistoryDetails = result.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Builder(builder: (context) {
                                  final orderStatus =
                                      OrderStatusExtension.getStatus(
                                          orderHistoryDetails.status ?? "");
                                  return Text("${orderStatus.name}",
                                      style: theme.textTheme.bodyText1
                                          ?.copyWith(
                                              color: orderStatus.color,
                                              fontWeight: FontWeight.w600));
                                }),
                                Text(
                                  'Purchased on  ${DateFormatterUtils.formatDateFromString(orderHistoryDetails.date)}',
                                  style: theme.textTheme.caption,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: config.appVerticalPaddingMedium()),
                              child: const Divider(),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Items",
                                    style: theme.textTheme.bodyText1?.copyWith(
                                        fontWeight: FontWeight.w600)),
                                config.verticalSpaceSmall(),
                                Builder(builder: (context) {
                                  final orderInfo =
                                      orderHistoryDetails.orderInfo;
                                  return Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                          orderInfo?.orderItems?.length ?? 0,
                                          (index) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            OrderDetailItemCard(
                                                orderItem: orderInfo
                                                    ?.orderItems?[index]),
                                            config.verticalSpaceSmall(),
                                          ],
                                        );
                                      }),
                                    ),
                                  );
                                }),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          config.appHorizontalPaddingSmall(),
                                      vertical:
                                          config.appVerticalPaddingSmall()),
                                  width: double.maxFinite,
                                  color: kWhite400,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(children: [
                                          TextSpan(
                                            text: "SubTotal : ",
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(color: Colors.grey),
                                          ),
                                          TextSpan(
                                              text:
                                                  "$currency ${NumberParser.twoDecimalDigit(orderHistoryDetails.orderInfo?.subTotal.toString())}"),
                                        ]),
                                      ),
                                      config.verticalSpaceSmall(),
                                      Text.rich(
                                        TextSpan(children: [
                                          TextSpan(
                                            text: "Shipping & Handling : ",
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(color: Colors.grey),
                                          ),
                                          TextSpan(
                                              text:
                                                  "${NumberParser.twoDecimalDigit(orderHistoryDetails.orderInfo?.shippingFee.toString())}"),
                                        ]),
                                      ),
                                      config.verticalSpaceSmall(),
                                      Text.rich(
                                        TextSpan(children: [
                                          TextSpan(
                                            text: "Grand total : ",
                                            style: theme.textTheme.bodyText1
                                                ?.copyWith(color: Colors.grey),
                                          ),
                                          TextSpan(
                                              text:
                                                  "${NumberParser.twoDecimalDigit(orderHistoryDetails.orderInfo?.grandTotal.toString())}",
                                              style: theme.textTheme.bodyText1),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          config.appVerticalPaddingMedium()),
                                  child: const Divider(),
                                ),
                                _ShippingAddressInfo(
                                  title: 'Shipping Address',
                                  shippingAddress:
                                      orderHistoryDetails.shippingAddress,
                                ),
                                config.verticalSpaceLarge(),
                                _ShippingAddressInfo(
                                  title: "Billing Address",
                                  shippingAddress:
                                      orderHistoryDetails.billingAddress,
                                ),
                                config.verticalSpaceLarge(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  theme.colorScheme.secondary)),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Payment Method",
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          config.verticalSpaceSmall(),
                                          Text(
                                              "${orderHistoryDetails.paymentMethod}")
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  theme.colorScheme.secondary)),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Shipping Method",
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          config.verticalSpaceSmall(),
                                          Text(
                                              "${orderHistoryDetails.shippingMethodInfo?.name}")
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        );
                      } else if (result.hasError) {
                        return ErrorView(
                          title: NetworkException.getErrorMessage(result.error),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ShimmerWidget.rounded(
                                    width: config.appWidth(20),
                                    height: 15,
                                    borderRadius: 3),
                                ShimmerWidget.rounded(
                                    width: config.appWidth(35),
                                    height: 15,
                                    borderRadius: 3),
                              ],
                            ),
                            config.verticalSpaceCustom(0.13),
                            ShimmerWidget.rounded(
                                width: config.appWidth(25),
                                height: 15,
                                borderRadius: 3),
                            config.verticalSpaceMedium(),
                            ShimmerWidget.rounded(
                                width: double.maxFinite,
                                height: 100,
                                borderRadius: 3),
                            config.verticalSpaceMedium(),
                            ShimmerWidget.rounded(
                                width: double.maxFinite,
                                height: 100,
                                borderRadius: 3),
                          ],
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ));
    });
  }
}

class _ShippingAddressInfo extends StatelessWidget {
  final String title;
  final Address? shippingAddress;

  const _ShippingAddressInfo({
    Key? key,
    required this.title,
    required this.shippingAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyText2
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          config.verticalSpaceSmall(),
          Text(
            "${shippingAddress?.city} ",
            // "${shippingAddress?.firstName} ${shippingAddress?.lastName}",
            style: theme.textTheme.bodyText2?.copyWith(color: Colors.grey),
          ),
          config.verticalSpaceSmall(),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: theme.primaryColor,
                size: 20,
              ),
              config.horizontalSpaceSmall(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${shippingAddress?.country}, ${shippingAddress?.city}, ${shippingAddress?.postalCode}, ${shippingAddress?.address}",
                    style:
                        theme.textTheme.bodyText2?.copyWith(color: Colors.grey),
                  ),
                  config.verticalSpaceSmall(),
                  Text(
                    // "${shippingAddress?.phoneNumber}","phon"
                    "phone_number",
                    style:
                        theme.textTheme.bodyText2?.copyWith(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
        ],
      );
    });
  }
}
