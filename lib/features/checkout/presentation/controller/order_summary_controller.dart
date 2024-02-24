import 'package:flutter/material.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/loading_dialog.dart';
import 'package:yeshelpinghand/core/presentation/widgets/snackbar.dart';
import 'package:yeshelpinghand/features/cart/presentation/controller/cart_controller.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/confirm_order_params.dart';
import 'package:yeshelpinghand/features/checkout/data/model/response/order_place_result.dart';
import 'package:yeshelpinghand/features/checkout/domain/repository/checkout_repository.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/features/checkout/presentation/screen/order_success_screen.dart';

class OrderSummaryController extends GetxController {
  @override
  void onInit() {
    fetchOrderSummary();
    super.onInit();
  }

  ApiResponse _orderSummaryResponse = ApiResponse();

  ApiResponse get orderSummaryResponse => _orderSummaryResponse;

  set orderSummaryResponse(ApiResponse response) {
    _orderSummaryResponse = response;
    update();
  }

  fetchOrderSummary() async {
    orderSummaryResponse =
        await Get.find<CheckoutRepository>().fetchOrderSummary();
  }

  placeOrder(
      BuildContext context, ConfirmOrderParams confirmOrderParams) async {
    showLoadingDialog(context);
    String? shippingAddressId =
        confirmOrderParams.shippingAddress?.id.toString();
    String? billingAddressId = confirmOrderParams.billingAddress?.id.toString();
    final result = await Get.find<CheckoutRepository>()
        .placeOrder(billingAddressId!, shippingAddressId!);
    hideLoadingDialog(context);
    if (result.hasData) {
      Get.find<CartController>().getCartDetails();
      // final OrderPlaceResult orderResult = result.data;

      showDialog(context: context, builder: (context) => OrderSuccessDialog());
      Get.find<CartController>().getCartDetails();
    } else if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
  }
}
