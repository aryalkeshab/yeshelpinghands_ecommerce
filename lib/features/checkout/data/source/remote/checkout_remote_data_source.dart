import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/payment_status_update_params.dart';

import '../../model/request/confirm_order_params.dart';

abstract class CheckoutRemoteDataSource {
  Future<dynamic> fetchShippingMethods();

  Future<dynamic> fetchOrderSummary();

  Future<dynamic> fetchPaymentMethods();

  Future<dynamic> setShippingInfo(ConfirmOrderParams confirmOrderParams);

  Future<dynamic> setPaymentMethod(String paymentMethod);

  Future<dynamic> placeOrder(String billingId, String shippingId);

  Future<dynamic> updatePaymentStatus(PaymentStatusUpdateParams params);
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final ApiClient apiClient;

  CheckoutRemoteDataSourceImpl({required this.apiClient});

  @override
  Future fetchShippingMethods() {
    return apiClient
        .authGet(APIPathHelper.checkoutAPIs(APIPath.shippingMethods));
  }

  @override
  Future fetchOrderSummary() {
    return apiClient.authGet(APIPathHelper.checkoutAPIs(APIPath.orderSummary));
  }

  @override
  Future setShippingInfo(ConfirmOrderParams confirmOrderParams) {
    return apiClient.authPost(
        APIPathHelper.checkoutAPIs(APIPath.shippingAndBillingAddress),
        data: confirmOrderParams.toShippingInfoJson());
  }

  @override
  Future fetchPaymentMethods() {
    return apiClient.authGet(
      APIPathHelper.checkoutAPIs(APIPath.paymentMethods),
    );
  }

  @override
  Future setPaymentMethod(String paymentMethod) {
    return apiClient.authPost(
        APIPathHelper.checkoutAPIs(APIPath.paymentMethods),
        data: {"payment": paymentMethod});
  }

  @override
  Future placeOrder(String billingId, String shippingId) {
    return apiClient.authPost(
      APIPathHelper.checkoutAPIs(APIPath.placeOrder),
      data: {
        "shipping_address_id": shippingId,
        "billing_address_id": billingId,
      },
    );
  }

  @override
  Future updatePaymentStatus(PaymentStatusUpdateParams params) {
    return apiClient.authPost(
      APIPathHelper.checkoutAPIs(
        APIPath.updatePaymentStatus,
      ),
      data: params.toJson(),
    );
  }
}
