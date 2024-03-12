import 'package:get/get.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/features/product/presentation/product_listing/widgets/range_slider.dart';
import '../../../data/model/request/filter_query_params.dart';
import '../../controller/product_listing_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductListingController>(builder: (controller) {
      return SafeArea(
        child: Drawer(
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
                    config.verticalSpaceMedium(),
                    const Divider(),
                    config.verticalSpaceSmall(),
                    PriceRangeSlider(
                      lowerLimit: 100,
                      upperLimit: 50000,
                      previousMax: controller.maxPrice ?? 50000,
                      previousMin: controller.minPrice ?? 100,
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
                    config.verticalSpaceMedium(),
                    PrimaryButton(
                        label: "Apply",
                        onPressed: () {
                          widget.filterQueryParams.minPrice = selectedFilterParams.minPrice;
                          widget.filterQueryParams.maxPrice = selectedFilterParams.maxPrice;
                          Get.find<ProductListingController>()
                              .onProductsFilter(context, widget.filterQueryParams);

                          // widget.onFilterUpdate();

                          Scaffold.of(context).closeEndDrawer();
                        }),
                  ],
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
