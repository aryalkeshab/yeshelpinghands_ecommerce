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

  CartRepositoryImpl(
      {required this.cartRemoteDataSource, required this.networkInfo});

  @override
  Future<ApiResponse> getCartDetails() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await cartRemoteDataSource.getCartDetails();
        if (result.isEmpty) {
          return ApiResponse(data: CartResponse.init());
        }

        final cartResponse = CartResponse.fromJson(result[0]);
        return ApiResponse(data: cartResponse);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }

  @override
  Future<ApiResponse> removeProductFromCart(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await cartRemoteDataSource.removeProductFromCart(id);

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
        final response =
            await cartRemoteDataSource.updateCart(updateCartParams);

        return ApiResponse(data: response[0]['message']);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.badResponse) {
          return ApiResponse(
              error: NetworkException.defaultError(
                  value: "${e.response?.data[0]['error']}"));
        }
        {
          return ApiResponse(error: NetworkException.getException(e));
        }
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }
}
