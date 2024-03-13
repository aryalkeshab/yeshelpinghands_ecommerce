import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/cart/data/data_source/remote/cart_remote_data_source.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/cart_request_params.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/update_cart_params.dart';
import 'package:yeshelpinghand/features/cart/data/model/response/cart_details.dart';
import 'package:yeshelpinghand/features/cart/domain/repository/cart_repository.dart';
import 'package:dio/dio.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource cartRemoteDataSource;
  final NetworkInfo networkInfo;

  CartRepositoryImpl({required this.cartRemoteDataSource, required this.networkInfo});

  @override
  Future<ApiResponse> getCartDetails() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await cartRemoteDataSource.getCartDetails();
        final cartResponse = CartResponse.fromJson(result["data"]);
        return ApiResponse(data: cartResponse);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }

  @override
  Future<ApiResponse> removeProductFromCart(String slug) async {
    if (await networkInfo.isConnected) {
      try {
        await cartRemoteDataSource.removeProductFromCart(slug);

        return ApiResponse(data: 'Successfully Removed from Cart');
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> removeAllProductFromCart() async {
    if (await networkInfo.isConnected) {
      try {
        await cartRemoteDataSource.removeAllProductFromCart();

        return ApiResponse(data: 'Successfully Removed Products from Cart');
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> addToCartItems(CartParams cartParams) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await cartRemoteDataSource.addToCartItems(cartParams);

        return ApiResponse(data: 'Successfully Added to Cart');
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }

  @override
  Future<ApiResponse> updateCart(UpdateCartParams updateCartParams) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await cartRemoteDataSource.updateCart(updateCartParams);

        return ApiResponse(data: response['message']);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.badResponse) {
          return ApiResponse(
              error: NetworkException.defaultError(value: "${e.response?.data['error'] ?? ''}"));
        }
        {
          return ApiResponse(error: NetworkException.getException(e));
        }
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }
}
