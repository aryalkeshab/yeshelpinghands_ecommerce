import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/features/home/data/models/response/products_model.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import '../../../../../core/presentation/routes/app_pages.dart';
import '../../../../shared/layouts/product_card.dart';
import '../../controller/best_seller_controller.dart';
import '../shared/layouts.dart';

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BestSellerController>(builder: (controller) {
      final result = controller.bestSellerProductApiResponse;
      if (result.hasData) {
        final List<ProductModel> productList = result.data;

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SectionHeader(
                  title: "Trending Products",
                  onViewAllProductTap: () {
                    Get.toNamed(
                      Routes.productListingScreen,
                      arguments: FilterQueryParams(bestSeller: true, pageSize: 40),
                    );
                  }),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: BaseWidget(builder: (context, config, theme) {
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
      } else {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ShimmerWidget.rounded(height: 150, width: 120, borderRadius: 5),
              );
            }),
          ),
        );
      }
    });
  }
}
