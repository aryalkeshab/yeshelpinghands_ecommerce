import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/widgets/loading_dialog.dart';
import 'package:yeshelpinghand/core/presentation/widgets/snackbar.dart';
import 'package:yeshelpinghand/features/address/data/model/response/address.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/features/address/domain/repository/address_repository.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/confirm_order_params.dart';

import '../../../../core/presentation/routes/app_pages.dart';
import '../../domain/repository/checkout_repository.dart';

class ShippingAddressController extends GetxController {
  late GlobalKey<FormState> shippingKey;

  @override
  void onInit() {
    shippingKey = GlobalKey<FormState>();
    // fetchDefaultAddresses();
    super.onInit();
  }

  Address? defaultShippingAddress;

  Address? defaultBillingAddress;
  bool isFirstLoad = true;

  // fetchDefaultAddresses() async {
  //   final result = await Get.find<AddressRepository>().getDefaultAddresses();
  //   if (result.hasData) {
  //     final DefaultAddresses defaultAddresses = result.data;
  //     defaultBillingAddress = defaultAddresses.billingAddress;
  //     defaultShippingAddress = defaultAddresses.shippingAddress;
  //     update();
  //   }
  // }

  setCheckoutShippingInfo(
      BuildContext context, ConfirmOrderParams confirmOrderParams) async {
    showLoadingDialog(context);
    // final result = await Get.find<CheckoutRepository>()
    //     .setShippingInfo(confirmOrderParams);
    hideLoadingDialog(context);
    // if (result.hasData) {
    // AppSnackbar.showSuccess(context: context, message: result.data);
    Get.toNamed(Routes.paymentScreen, arguments: confirmOrderParams);
    // } else if (result.hasError) {
    //   AppSnackbar.showError(
    //       context: context,
    //       message: NetworkException.getErrorMessage(result.error));
    // }
  }
}
