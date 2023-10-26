import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/cart_request_params.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/update_cart_params.dart';

abstract class CartRemoteDataSource {
  Future<dynamic> getCartDetails();

  Future<dynamic> addToCartItems(CartParams cartParams);

  Future<dynamic> updateCart(UpdateCartParams updateCartParams);

  Future<dynamic> removeProductFromCart(String slug);

  Future<dynamic> removeAllProductFromCart();
}

class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final ApiClient apiClient;

  CartRemoteDataSourceImpl({required this.apiClient});

  @override
  Future getCartDetails() {
    return apiClient.authGet(APIPathHelper.cartAPIs(APIPath.getCartItems));
  }

  @override
  Future addToCartItems(CartParams cartParams) {
    return apiClient.authPost(APIPathHelper.cartAPIs(APIPath.addToCart),
        data: cartParams.toJson());
  }

  @override
  Future removeProductFromCart(String slug) {
    // List<String> updateCartParamsList = [];
    // updateCartParamsList.add(slug);
    return apiClient.authPost(
        APIPathHelper.cartAPIs(
          APIPath.updateCart,
        ),
        data: {"delete_product_slug": slug});
  }

  @override
  Future removeAllProductFromCart() {
    return apiClient
        .authGet(APIPathHelper.cartAPIs(APIPath.removeAllCartProducts));
  }

  @override
  Future updateCart(UpdateCartParams updateCartParams) {
    // List<String> updateCartParamsList = [];
    // List<int> updateCartParamsQtyInt = [];
    // updateCartParamsList.add(updateCartParams.cartItemId);
    // updateCartParamsQtyInt.add(updateCartParams.quantity);
    return apiClient.authPost(APIPathHelper.cartAPIs(APIPath.updateCart),
        data: updateCartParams.toJson());
  }
}
