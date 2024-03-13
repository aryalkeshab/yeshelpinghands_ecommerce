import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:get/get.dart';

class BillingAddressController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  late ApiResponse _billingAddressesResponse;

  set billingAddressesResponse(ApiResponse response) {
    _billingAddressesResponse = response;
    update();
  }

  ApiResponse get billingAddressesResponse => _billingAddressesResponse;
}
