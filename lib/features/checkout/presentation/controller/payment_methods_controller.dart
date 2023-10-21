import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/confirm_order_params.dart';
import 'package:yeshelpinghand/features/checkout/domain/repository/checkout_repository.dart';

import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../../core/presentation/routes/app_pages.dart';
import '../../../../core/presentation/widgets/loading_dialog.dart';
import '../../../../core/presentation/widgets/snackbar.dart';
import '../../../../core/presentation/widgets/toast.dart';
import '../../data/model/response/payment_method.dart';

class PaymentMethodsController extends GetxController {
  @override
  onInit() {
    super.onInit();
    fetchPaymentMethods();
  }

  ApiResponse _paymentMethodsApiResponse = ApiResponse();

  ApiResponse get paymentMethodsApiResponse => _paymentMethodsApiResponse;

  set paymentMethodsApiResponse(ApiResponse response) {
    _paymentMethodsApiResponse = response;
    update();
  }

  fetchPaymentMethods() async {
    paymentMethodsApiResponse =
        await Get.find<CheckoutRepository>().fetchPaymentMethods();
  }

  PaymentMethod? selectedPaymentMethod;

  setPaymentMethod(
      BuildContext context, ConfirmOrderParams confirmOrderParams) async {
    showLoadingDialog(context);

    final result = await Get.find<CheckoutRepository>()
        .setPaymentMethod("${confirmOrderParams.paymentMethod?.value}");

    if (result.hasData) {
      hideLoadingDialog(context);
      Get.toNamed(Routes.checkoutSummary, arguments: confirmOrderParams);

      showToast(result.data);
    } else if (result.hasError) {
      hideLoadingDialog(context);
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
  }
}
