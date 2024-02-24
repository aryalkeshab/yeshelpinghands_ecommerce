import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/features/product/data/model/response/filter_drawer_model.dart';
import 'package:yeshelpinghand/features/product/presentation/controller/filter_drawer_controller.dart';
import 'package:yeshelpinghand/features/product/presentation/product_listing/widgets/range_slider.dart';
import 'package:yeshelpinghand/features/product/presentation/product_listing/widgets/stock_status_widget.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';

import '../../../data/model/request/filter_query_params.dart';
import '../../controller/product_listing_controller.dart';
import 'category_filter_widget.dart';

class FilterDrawer extends StatefulWidget {
  final VoidCallback onFilterUpdate;
  final FilterQueryParams filterQueryParams;
  final VoidCallback onClearFilter;

  FilterDrawer(
    this.onFilterUpdate, {
    Key? key,
    required this.filterQueryParams,
    required this.onClearFilter,
  }) : super(key: key);

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  FilterQueryParams selectedFilterParams = FilterQueryParams();

  // int getSelectedIndexOfStockStatus() {
  //   final isInStockSelected =
  //       Get.find<FilterDrawerController>().filterQueryParams.inStock == true;
  //   final isOutOfStockSelected =
  //       Get.find<FilterDrawerController>().filterQueryParams.outOfStock == true;
  //   if (isInStockSelected) return 0;
  //   if (isOutOfStockSelected) return 1;
  //   return -1;
  // }

  @override
  Widget build(BuildContext context) {
    // final result = controller.filterModelResponse;
    // if (result.hasData) {
    // final FilterDrawerModel filter = result.data;
    return GetBuilder<ProductListingController>(builder: (controller) {
      return Drawer(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BaseWidget(builder: (context, config, theme) {
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: config.appHorizontalPaddingLarge(),
                  vertical: config.appVerticalPaddingLarge()),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  config.verticalSpaceLarge(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: PrimaryOutlinedButton(
                        title: 'Clear All',
                        onPressed: () {
                          widget.onClearFilter();
                          Scaffold.of(context).closeEndDrawer();
                        },
                        width: 2),
                  ),
                  // config.verticalSpaceMedium(),
                  // CategoryFilterWidget(
                  //   filter.subCategories,
                  //   initialCategory: Get.find<FilterDrawerController>()
                  //       .filterQueryParams
                  //       .categoryId,
                  //   onCategorySelect: (subCategory) {
                  //     selectedFilterParams.categoryId =
                  //         int.tryParse("${subCategory.id}") ?? 0;
                  //   },
                  // ),
                  config.verticalSpaceMedium(),
                  const Divider(),
                  config.verticalSpaceSmall(),
                  PriceRangeSlider(
                    lowerLimit: 100,
                    upperLimit: 50000,
                    previousMax: controller.maxPrice ?? 50000,
                    previousMin: controller.minPrice ?? 100,
                    // previousMin: double.tryParse(
                    //     "${Get.find<FilterDrawerController>().filterQueryParams.minPrice}"),
                    // previousMax: double.tryParse(
                    //     "${Get.find<FilterDrawerController>().filterQueryParams.maxPrice}"),
                    onRangeUpdate: (minVal, maxVal) {
                      selectedFilterParams
                        ..minPrice = minVal.toString()
                        ..maxPrice = maxVal.toString();

                      controller.maxPrice = maxVal;
                      controller.minPrice = minVal;
                    },
                  ),
                  config.verticalSpaceSmall(),
                  const Divider(),
                  config.verticalSpaceSmall(),
                  // if (filter.availability != null)
                  //   StockFilter(
                  //     selectedIndex: getSelectedIndexOfStockStatus(),
                  //     availability: filter.availability,
                  //     onStockUpdate: (isInStockSelected) {
                  //       if (isInStockSelected) {
                  //         selectedFilterParams
                  //           ..inStock = true
                  //           ..outOfStock = null;
                  //       } else {
                  //         selectedFilterParams
                  //           ..outOfStock = true
                  //           ..inStock = null;
                  //       }
                  //     },
                  //   ),
                  config.verticalSpaceMedium(),
                  PrimaryButton(
                      label: "Apply",
                      onPressed: () {
                        widget.filterQueryParams.minPrice =
                            selectedFilterParams.minPrice;
                        widget.filterQueryParams.maxPrice =
                            selectedFilterParams.maxPrice;
                        Get.find<ProductListingController>().onProductsFilter(
                            context, widget.filterQueryParams);

                        // widget.onFilterUpdate();

                        Scaffold.of(context).closeEndDrawer();
                      }),
                ],
              ),
            );
          }),
        ),
      );
    });
    // } else if (result.hasError) {
    //   return ErrorView(title: NetworkException.getErrorMessage(result.error));
    // } else {
    //   return const CircularProgressIndicator();
    // }
  }
}
