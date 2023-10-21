import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/features/order/presentation/controller/order_history_controller.dart';
import 'package:yeshelpinghand/features/order/presentation/empty_order_history.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/response/order.dart';
import 'widgets/order_card.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: BaseWidget(builder: (context, config, theme) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: config.appEdgePadding(),
              vertical: config.appVerticalPaddingMedium()),
          child: GetBuilder<OrderHistoryController>(
            init: OrderHistoryController(),
            builder: (controller) {
              final result = controller.orderHistoryResponse;
              if (result.hasData) {
                final List<Order> orderHistoryList = result.data;
                if (orderHistoryList.isEmpty) {
                  return const EmptyOrderHistoryScreen();
                }

                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return OrderCard(
                      order: orderHistoryList[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return config.verticalSpaceSmall();
                  },
                  itemCount: orderHistoryList.length,
                );
              } else if (result.hasError) {
                return const Center(
                  child: ErrorView(),
                );
              } else {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return const LoadingOrderCard();
                    },
                    separatorBuilder: (context, index) {
                      return config.verticalSpaceSmall();
                    },
                    itemCount: 4);
              }
            },
          ),
        );
      }),
    );
  }
}
