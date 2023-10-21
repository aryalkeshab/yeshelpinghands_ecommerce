import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/snackbar.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/payment_status_update_params.dart';
import 'package:yeshelpinghand/features/checkout/presentation/controller/checkout_controller.dart';
import 'package:yeshelpinghand/features/checkout/presentation/screen/order_success_screen.dart';
import 'package:yeshelpinghand/features/dashboard/controllers/dashboard_controller.dart';
import 'package:yeshelpinghand/features/paystack/data/model/request/paystack_initate_params.dart';
import 'package:yeshelpinghand/features/paystack/data/model/response/paystack_verify_transaction_model.dart';
import 'package:yeshelpinghand/features/paystack/domain/paystack_repository.dart';

import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../../core/presentation/widgets/loading_dialog.dart';
import '../paystack_screen.dart';

class PaystackController extends GetxController {
  initiateTransaction(
      BuildContext context, PaystackInitiateParams params) async {
    final transactionResult =
        await Get.find<PaystackRepository>().initiateTransaction(params);

    if (transactionResult.hasData) {
      Get.toNamed(Routes.paystackScreen,
          arguments: PaystackScreenParams(
              paymentUrl: transactionResult.data,
              referenceNo: params.reference));
    } else if (transactionResult.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(transactionResult.error));
    }
  }

  verifyTransaction(BuildContext context, reference) async {
    showLoadingDialog(context);
    final result =
        await Get.find<PaystackRepository>().verifyTransaction(reference);
    hideLoadingDialog(context);
    if (result.hasData) {
      final PaystackVerifyTransactionModel paystackTransaction = result.data;

      final authorization = PaymentStatusUpdateAuthorization(
        expiryMonth: paystackTransaction.data?.authorization?.expiryMonth,
        expiryYear: paystackTransaction.data?.authorization?.expiryYear,
        cardType: paystackTransaction.data?.authorization?.cardType,
        last4: paystackTransaction.data?.authorization?.cardNumber,
      );

      final data = PaymentStatusUpdateData(
        authorization: authorization,
        id: paystackTransaction.data?.id,
        gatewayResponse: paystackTransaction.data?.gatewayResponse,
        status: paystackTransaction.data?.status,
      );

      final paymentStatusUpdateParams = PaymentStatusUpdateParams(
        status: paystackTransaction.status,
        data: data,
        message: paystackTransaction.message,
        reference: reference,
      );

      if (paystackTransaction.data?.status == "success") {
        Get.find<CheckoutController>()
            .updatePaymentStatus(paymentStatusUpdateParams);
        AppSnackbar.showSuccess(
            context: context, message: " Your transaction is approved");
        showDialog(
          context: context,
          builder: (context) => OrderSuccessDialog(),
        );
      } else {
        if (paystackTransaction.data?.status != "abandoned") {
          Get.find<CheckoutController>()
              .updatePaymentStatus(paymentStatusUpdateParams);
        }
        AppSnackbar.showError(
            context: context,
            message: "${paystackTransaction.data?.gatewayResponse}");
        Get.until((route) => route.settings.name == Routes.dashboard);
        Get.find<DashboardController>().changeTabIndex(0);
      }
    } else if (result.hasError) {
      AppSnackbar.showError(context: context, message: "${result.error}");
      Get.until((route) => route.settings.name == Routes.dashboard);
      Get.find<DashboardController>().changeTabIndex(0);
    } else {}
  }
}
