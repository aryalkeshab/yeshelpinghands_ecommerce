import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/cart_request_params.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/update_cart_params.dart';

abstract class CartRepository {
  Future<ApiResponse> getCartDetails();
  Future<ApiResponse> updateCart(UpdateCartParams updateCartParams);
  Future<ApiResponse> removeProductFromCart(String slug);
  Future<ApiResponse> removeAllProductFromCart();

  Future<ApiResponse> addToCartItems(CartParams cartParams);
}
