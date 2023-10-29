import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/confirm_order_params.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/payment_status_update_params.dart';

abstract class CheckoutRepository {
  Future<ApiResponse> fetchShippingMethods();
  Future<ApiResponse> fetchPaymentMethods();
  Future<ApiResponse> fetchOrderSummary();
  Future<ApiResponse> setShippingInfo(ConfirmOrderParams confirmOrderParams);
  Future<ApiResponse> setPaymentMethod(String paymentMethod);
  Future<ApiResponse> placeOrder(String billingId, String shippingId);
  Future<ApiResponse> updatePaymentStatus(PaymentStatusUpdateParams params);
}
