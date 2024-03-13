import 'package:yeshelpinghand/core/presentation/resources/colors.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/core/utils/date_formatter_utils.dart';
import 'package:yeshelpinghand/core/utils/constants.dart';
import 'package:yeshelpinghand/features/order/data/response/order.dart';
import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/base_widget.dart';
import '../utils/order_status_enum.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, config, themeData) {
        return InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: kWhite400, borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: config.appVerticalPaddingMedium()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Order No: ${order.uniqueId}", style: themeData.textTheme.bodyText1),
                          config.verticalSpaceSmall(),
                          Text(
                            "$currency ${order.total}",
                            style: themeData.textTheme.bodyText1
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          config.verticalSpaceSmall(),
                        ],
                      ),
                      config.verticalSpaceSmall(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ordered By  ${order.firstName} ${order.lastName}",
                            style: themeData.textTheme.caption,
                          ),
                          Text(
                            "Purchased on  ${DateFormatterUtils.formatDateFromString(order.createdAt)}",
                            style: themeData.textTheme.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Transform.rotate(
                    angle: 0,
                    child: Builder(builder: (context) {
                      final orderStatus = OrderStatusExtension.getStatus("${order.orderStatus}");
                      return Text(
                        "${orderStatus.name}",
                        style: themeData.textTheme.bodyText2?.copyWith(color: orderStatus.color),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class LoadingOrderCard extends StatelessWidget {
  const LoadingOrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, config, themeData) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShimmerWidget.rounded(height: 10, width: config.appWidth(30), borderRadius: 0),
                  config.verticalSpaceMedium(),
                  ShimmerWidget.rounded(height: 10, width: config.appWidth(10), borderRadius: 0),
                  config.verticalSpaceMedium(),
                  ShimmerWidget.rounded(height: 10, width: config.appWidth(20), borderRadius: 0),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: ShimmerWidget.rounded(height: 10, width: 100, borderRadius: 0),
              ),
            ],
          ),
        );
      },
    );
  }
}
