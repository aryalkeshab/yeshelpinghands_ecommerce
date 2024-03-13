import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/home_controller.dart';
import 'package:yeshelpinghand/features/product/presentation/product_listing/product_listing_screen.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../shared/layouts/product_card.dart';

class HomeProductsView extends StatefulWidget {
  const HomeProductsView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeProductsView> createState() => _HomeProductsViewState();
}

class _HomeProductsViewState extends State<HomeProductsView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      final result = controller.allProductApiResponse;
      return BaseWidget(builder: (context, config, theme) {
        if (result.hasData) {
          final productList = controller.productList;
          return GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: List.generate(productList.length, (index) {
              final product = productList[index];

              return ProductCard.large(
                productModel: product,
                onWishlistButtonClick: () {},
                // onCartButtonClick: () {},
              );
            }),
          );
        } else if (result.hasError) {
          return Center(
            child: ErrorView(
              title: NetworkException.getErrorMessage(result.error),
            ),
          );
        } else {
          return const LoadingProductListView();
        }
      });
    });
  }
}
