import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import 'package:yeshelpinghand/features/product/presentation/controller/filter_drawer_controller.dart';
import 'package:yeshelpinghand/features/product/presentation/controller/product_listing_controller.dart';
import 'package:yeshelpinghand/features/product/presentation/product_listing/widgets/product_filter_drawer.dart';
import 'package:yeshelpinghand/features/product/presentation/product_listing/widgets/product_list_appbar.dart';
import 'package:yeshelpinghand/features/product/presentation/product_listing/widgets/product_list_view.dart';
import 'package:yeshelpinghand/features/shared/layouts/empty_list_view.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductListingScreen extends StatefulWidget {
  FilterQueryParams filterQueryParams;

  ProductListingScreen({Key? key, required this.filterQueryParams})
      : super(key: key);

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(FilterDrawerController())
        .fetchFilterModel(widget.filterQueryParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawerEnableOpenDragGesture: false,
      endDrawer: FilterDrawer(
        onClearFilter: () {
          final filterController = Get.find<FilterDrawerController>();
          filterController.clearFilter();
          widget.filterQueryParams = filterController.filterQueryParams;
          Get.find<ProductListingController>()
              .onProductsFilter(context, widget.filterQueryParams);
        },
        () {
          widget.filterQueryParams =
              Get.find<FilterDrawerController>().filterQueryParams;
          Get.find<ProductListingController>()
              .onProductsFilter(context, widget.filterQueryParams);
        },
      ),
      appBar: ProductListingAppBar(
        onSortUpdate: (onUpdateParams) {
          widget.filterQueryParams = onUpdateParams(widget.filterQueryParams);
          Get.find<ProductListingController>()
              .onProductsFilter(context, widget.filterQueryParams);
        },
      ),
      body: GetBuilder<ProductListingController>(
          init: ProductListingController(widget.filterQueryParams),
          builder: (controller) {
            return BaseWidget(builder: (context, config, theme) {
              return Padding(
                padding: EdgeInsets.only(
                  top: config.appVerticalPaddingSmall(),
                  left: config.appEdgePadding(),
                  right: config.appEdgePadding(),
                  bottom: config.appHeight(6),
                ),
                child: SmartRefresher(
                  physics: BouncingScrollPhysics(),
                  controller: controller.refreshController,
                  enablePullUp: false,
                  enablePullDown: true,
                  onRefresh: () =>
                      controller.fetchProductList(widget.filterQueryParams),
                  child: GetBuilder<ProductListingController>(
                      builder: (controller) {
                    final result = Get.find<ProductListingController>()
                        .productListResponse;

                    if (result.hasData) {
                      final productsList = controller.productList;
                      return productsList.isEmpty
                          ? SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  config.verticalSpaceExtraLarge(),
                                  const EmptyListView(
                                    title:
                                        'We can\'t find products matching the selection.',
                                  ),
                                ],
                              ),
                            )
                          : ProductListViewBuilder(
                              productList: controller.productList,
                            );
                    } else if (result.hasError) {
                      return Center(
                        child: ErrorView(
                            title:
                                "${NetworkException.getErrorMessage(result.error)}"),
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
          return ShimmerWidget.rounded(
              height: 170, width: 130, borderRadius: 10);
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
      return Padding(
        padding: EdgeInsets.only(right: config.appEdgePadding()),
        child: InkWell(
          onTap: () => Scaffold.of(context).openEndDrawer(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.filter_alt_sharp,
                color: Colors.white,
              ),
              const Text(
                'Filter',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    });
  }
}
