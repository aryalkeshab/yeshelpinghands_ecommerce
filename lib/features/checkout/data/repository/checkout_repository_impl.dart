import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/confirm_order_params.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/payment_status_update_params.dart';
import 'package:yeshelpinghand/features/checkout/data/model/response/order_place_result.dart';
import 'package:yeshelpinghand/features/checkout/data/model/response/order_summary.dart';
import 'package:yeshelpinghand/features/checkout/data/model/response/payment_method.dart';
import 'package:yeshelpinghand/features/checkout/data/model/response/shipping_method_response.dart';
import 'package:yeshelpinghand/features/checkout/data/source/remote/checkout_remote_data_source.dart';
import 'package:yeshelpinghand/features/checkout/domain/repository/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final NetworkInfo networkInfo;
  final CheckoutRemoteDataSource checkoutRemoteDataSource;

  CheckoutRepositoryImpl(
      {required this.networkInfo, required this.checkoutRemoteDataSource});

  @override
  Future<ApiResponse> fetchShippingMethods() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await checkoutRemoteDataSource.fetchShippingMethods();
        final shippingMethods = result
            .map<ShippingMethod>((e) => ShippingMethod.fromJson(e))
            .toList();
        return ApiResponse(data: shippingMethods);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> fetchOrderSummary() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await checkoutRemoteDataSource.fetchOrderSummary();
        final orderSummaryResponse = OrderSummary.fromJson(result[0]);
        return ApiResponse(data: orderSummaryResponse);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> setShippingInfo(
      ConfirmOrderParams confirmOrderParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await checkoutRemoteDataSource.setShippingInfo(confirmOrderParams);

        return ApiResponse(data: result[0]['message']);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> fetchPaymentMethods() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await checkoutRemoteDataSource.fetchPaymentMethods();
        final paymentMethods = result
            .map<PaymentMethod>((e) => PaymentMethod.fromJson(e))
            .toList();
        return ApiResponse(data: paymentMethods);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> setPaymentMethod(String paymentMethod) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await checkoutRemoteDataSource.setPaymentMethod(paymentMethod);

        return ApiResponse(data: result[0]['message']);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> placeOrder(String billingId, String shippingId) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await checkoutRemoteDataSource.placeOrder(billingId, shippingId);

        return ApiResponse(data: result['message']);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> updatePaymentStatus(
      PaymentStatusUpdateParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await checkoutRemoteDataSource.updatePaymentStatus(params);

        return ApiResponse(
            data: OrderPlaceResult.fromJson(result[0]['success']));
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
