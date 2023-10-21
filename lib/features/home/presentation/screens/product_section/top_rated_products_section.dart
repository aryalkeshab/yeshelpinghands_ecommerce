import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/features/home/data/models/response/products_model.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/home_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/top_rated_controller.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../shared/layouts/product_card.dart';
import '../shared/layouts.dart';

class TopRatedProductsSection extends StatelessWidget {
  const TopRatedProductsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return GetBuilder<TopRatedController>(builder: (controller) {
        final result = controller.topRatedProductApiResponse;
        if (result.hasData) {
          return Container(
            padding:
                EdgeInsets.only(bottom: config.appHorizontalPaddingMedium()),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SectionHeader(
                    title: "Top Rated Products",
                    onViewAllProductTap: () {
                      Get.toNamed(
                        Routes.productListingScreen,
                        arguments:
                            FilterQueryParams(topRated: true, pageSize: 40),
                      );
                    }),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: BaseWidget(builder: (context, config, theme) {
                    final List<ProductModel> productList = result.data;
                    return Row(
                      children: List.generate(productList.length, (index) {
                        final product = productList[index];
                        return Row(
                          children: [
                            ProductCard.small(
                              onCartButtonClick: () {},
                              onWishlistButtonClick: () {},
                              productModel: product,
                            ),
                            config.horizontalSpaceSmall(),
                          ],
                        );
                      }),
                    );
                  }),
                ),
              ],
            ),
          );
        } else if (result.hasError) {
          return const SizedBox.shrink();
          return Center(
            child: ErrorView(
              title: NetworkException.getErrorMessage(result.error),
            ),
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(3, (index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ShimmerWidget.rounded(
                      height: 150, width: 120, borderRadius: 5),
                );
              }),
            ),
          );
        }
      });
    });
  }
}
