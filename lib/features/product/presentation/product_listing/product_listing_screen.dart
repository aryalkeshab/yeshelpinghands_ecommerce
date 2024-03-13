import 'package:flutter/cupertino.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import 'package:yeshelpinghand/features/product/presentation/controller/product_listing_controller.dart';
import 'package:yeshelpinghand/features/product/presentation/product_listing/widgets/product_filter_drawer.dart';
import 'package:yeshelpinghand/features/product/presentation/product_listing/widgets/product_list_appbar.dart';
import 'package:yeshelpinghand/features/product/presentation/product_listing/widgets/product_list_view.dart';
import 'package:yeshelpinghand/features/shared/layouts/empty_list_view.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductListingScreen extends StatefulWidget {
  FilterQueryParams filterQueryParams;
  final bool? isDash;

  ProductListingScreen({Key? key, required this.filterQueryParams, this.isDash = false})
      : super(key: key);

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  @override
  void initState() {
    Get.put(ProductListingController(widget.filterQueryParams));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: FilterDrawer(
        onClearFilter: () {
          Get.find<ProductListingController>().minPrice = null;
          Get.find<ProductListingController>().maxPrice = null;
        },
        () {},
        filterQueryParams: widget.filterQueryParams,
      ),
      appBar: ProductListingAppBar(
        isDash: widget.isDash,
        onSortUpdate: (onUpdateParams) {
          widget.filterQueryParams = onUpdateParams(widget.filterQueryParams);

          Get.find<ProductListingController>().onProductsFilter(context, widget.filterQueryParams);
        },
      ),
      body: GetBuilder<ProductListingController>(builder: (controller) {
        return BaseWidget(builder: (context, config, theme) {
          return Padding(
            padding: EdgeInsets.only(
              left: config.appEdgePadding(),
              right: config.appEdgePadding(),
            ),
            child: SmartRefresher(
              physics: BouncingScrollPhysics(),
              controller: controller.refreshController,
              enablePullUp: false,
              enablePullDown: true,
              onRefresh: () => controller.fetchProductList(widget.filterQueryParams),
              child: GetBuilder<ProductListingController>(builder: (controller) {
                final result = Get.find<ProductListingController>().productListResponse;

                if (result.hasData) {
                  final productsList = controller.productList;
                  return productsList.isEmpty
                      ? SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              config.verticalSpaceExtraLarge(),
                              const EmptyListView(
                                title: 'We can\'t find products matching the selection.',
                              ),
                            ],
                          ),
                        )
                      : ProductListViewBuilder(
                          productList: controller.productList,
                        );
                } else if (result.hasError) {
                  return Center(
                    child: ErrorView(title: "${NetworkException.getErrorMessage(result.error)}"),
                  );
                } else {
                  return const LoadingProductListView();
                }
              }),
            ),
          );
        });
      }),
    );
  }
}

class LoadingProductListView extends StatelessWidget {
  const LoadingProductListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: List.generate(
        5,
        (index) {
          return ShimmerWidget.rounded(height: 170, width: 130, borderRadius: 10);
        },
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return InkWell(
        onTap: () => Scaffold.of(context).openEndDrawer(),
        child: Container(
          height: config.appHeight(4),
          width: config.appWidth(8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Icon(
            CupertinoIcons.slider_horizontal_3,
            color: theme.primaryColor,
          ),
        ),
      );
    });
  }
}
