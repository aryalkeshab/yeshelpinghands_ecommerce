import 'package:yeshelpinghand/features/home/data/models/response/products_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../shared/layouts/product_card.dart';

class ProductListViewBuilder extends StatelessWidget {
  final List<ProductModel> productList;

  const ProductListViewBuilder({
    Key? key,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return ProductCard.large(
          productModel: product,
          onWishlistButtonClick: () {},
          onCartButtonClick: () {},
        );
      },
    );
    // return StaggeredGrid.count(
    //   crossAxisCount: 2,
    //   mainAxisSpacing: 10,
    //   crossAxisSpacing: 10,
    //   children: List.generate(productList.length, (index) {
    //     final product = productList[index];
    //     return ProductCard.large(
    //       productModel: product,
    //       onWishlistButtonClick: () {},
    //       onCartButtonClick: () {},
    //     );
    //   }),
    // );
  }
}
