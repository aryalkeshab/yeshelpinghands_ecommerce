import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/features/dashboard/controllers/dashboard_controller.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
import 'package:yeshelpinghand/features/wishlist/data/model/wishlist.dart';
import 'package:yeshelpinghand/features/wishlist/presentation/controller/wishlist_controller.dart';
import 'package:yeshelpinghand/features/wishlist/presentation/screen/widgets/empty_wishlist.dart';
import 'package:yeshelpinghand/features/wishlist/presentation/screen/widgets/wishlist_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/layouts/confirm_dialog_view.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    Get.find<WishListController>().getWishList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, config, themeData) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              BaseWidget(builder: (context, config, theme) {
                return InkWell(
                    onTap: () {
                      Get.back();
                      Get.find<DashboardController>().changeTabIndex(2);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(right: config.appEdgePadding()),
                        child: GetBuilder<WishListController>(
                          builder: (controller) {
                            return InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return ConfirmDialogView(
                                          primaryText:
                                              "Are you sure you want to clear all the items from your wishlist?",
                                          onApproveButtonPressed: () {
                                            Get.find<WishListController>()
                                                .clearProductFromWishList(context);
                                          },
                                          onCancelButtonPressed: Get.back);
                                    },
                                  );
                                },
                                child: Visibility(
                                    visible: controller.wishlistResponse.data?.isNotEmpty == true,
                                    replacement: const SizedBox.shrink(),
                                    child: const Icon(
                                      CupertinoIcons.delete,
                                      size: 18,
                                    )));
                          },
                        )));
              })
            ],
            title: const Text('Wishlist'),
          ),
          body: GetBuilder<WishListController>(
              init: WishListController(),
              builder: (controller) {
                return SmartRefresher(
                  controller: controller.refreshController,
                  enablePullUp: false,
                  header: const WaterDropHeader(),
                  enablePullDown: true,
                  onRefresh: () => controller.getWishList(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: config.appEdgePadding()),
                    child: GetBuilder<WishListController>(builder: (context) {
                      final result = Get.find<WishListController>().wishlistResponse;

                      if (result.hasData) {
                        final List<WishListProduct> wishlists = result.data;
                        if (wishlists.isEmpty) {
                          return const EmptyWishListScreen();
                        }

                        return ListView.builder(
                          itemCount: wishlists.length,
                          itemBuilder: (context, index) {
                            final wishlist = wishlists[index];
                            return WishlistCard(
                              wishListProduct: wishlist,
                            );
                          },
                        );
                      } else if (result.hasError) {
                        return Center(
                          child: ErrorView(
                            title: "${NetworkException.getErrorMessage(result.error)}",
                          ),
                        );
                      } else {
                        return const WishlistLoadingView();
                      }
                    }),
                  ),
                );
              }),
        );
      },
    );
  }
}

class WishlistLoadingView extends StatelessWidget {
  const WishlistLoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return BaseWidget(builder: (context, config, theme) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(config.appEdgePadding()),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShimmerWidget.rounded(width: config.appWidth(25), height: config.appWidth(20)),
                    config.horizontalSpaceMedium(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ShimmerWidget.rounded(
                              width: config.appWidth(30), height: 12, borderRadius: 3),
                          config.verticalSpaceMedium(),
                          ShimmerWidget.rounded(
                              width: config.appWidth(10), height: 12, borderRadius: 3),
                          config.verticalSpaceMedium(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ShimmerWidget.rounded(
                                  width: config.appWidth(20), height: 15, borderRadius: 3),
                              ShimmerWidget.rounded(
                                  width: config.appWidth(15), height: 15, borderRadius: 3),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}
