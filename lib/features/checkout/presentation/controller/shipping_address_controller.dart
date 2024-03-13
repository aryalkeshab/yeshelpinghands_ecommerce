import 'package:yeshelpinghand/core/presentation/widgets/loading_dialog.dart';
import 'package:yeshelpinghand/features/address/data/model/response/address.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/confirm_order_params.dart';

import '../../../../core/presentation/routes/app_pages.dart';

class ShippingAddressController extends GetxController {
  late GlobalKey<FormState> shippingKey;

  @override
  void onInit() {
    shippingKey = GlobalKey<FormState>();
    super.onInit();
  }

  Address? defaultShippingAddress;

  Address? defaultBillingAddress;
  bool isFirstLoad = true;

  setCheckoutShippingInfo(BuildContext context, ConfirmOrderParams confirmOrderParams) async {
    showLoadingDialog(context);
    hideLoadingDialog(context);
    Get.toNamed(Routes.paymentScreen, arguments: confirmOrderParams);
  }
}
