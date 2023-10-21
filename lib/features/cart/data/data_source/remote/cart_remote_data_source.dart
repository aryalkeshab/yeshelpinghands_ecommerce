import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/cart_request_params.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/update_cart_params.dart';

abstract class CartRemoteDataSource {
  Future<dynamic> getCartDetails();

  Future<dynamic> addToCartItems(CartParams cartParams);

  Future<dynamic> updateCart(UpdateCartParams updateCartParams);

  Future<dynamic> removeProductFromCart(int id);

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
  Future removeProductFromCart(int id) {
    return apiClient.authDelete(
        APIPathHelper.cartAPIs(APIPath.removeCartItem, id: id.toString()));
  }

  @override
  Future removeAllProductFromCart() {
    return apiClient
        .authDelete(APIPathHelper.cartAPIs(APIPath.removeAllCartProducts));
  }

  @override
  Future updateCart(UpdateCartParams updateCartParams) {
    return apiClient.authPut(APIPathHelper.cartAPIs(APIPath.updateCart),
        data: updateCartParams.toJson());
  }
}
