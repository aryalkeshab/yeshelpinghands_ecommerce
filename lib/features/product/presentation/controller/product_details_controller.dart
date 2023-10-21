import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/data/data_source/remote/api_result.dart';
import '../../../home/domain/repository/products_repository.dart';
import '../../../wishlist/presentation/controller/wishlist_controller.dart';
import '../../data/model/response/product_details.dart';

class ProductDetailsController extends GetxController {
  final String sku;

  ProductDetailsController(this.sku);

  @override
  void onInit() {
    super.onInit();
    fetchProductDetails(sku);
  }

  ApiResponse _productDetailsResponse = ApiResponse();

  set productDetailsResponse(ApiResponse response) {
    _productDetailsResponse = response;
    update();
  }

  ApiResponse get productDetailsResponse => _productDetailsResponse;

  fetchProductDetails(String sku) async {
    productDetailsResponse =
        await Get.find<ProductsRepository>().getProductDetails(sku);
  }

  onTapFav(BuildContext context, ProductDetails productDetails) async {
    Get.find<WishListController>().removeProductFromWishList(
      context,
      int.parse(productDetails.entityId!),
    );
    fetchProductDetails(sku);
  }
}
