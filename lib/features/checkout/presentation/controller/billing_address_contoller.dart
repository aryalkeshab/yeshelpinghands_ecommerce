import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/address/data/model/response/address.dart';
import 'package:get/get.dart';

class BillingAddressController extends GetxController {
  @override
  void onInit() {
    fetchSavedShippingAddresses();
    super.onInit();
  }

  late ApiResponse _billingAddressesResponse;

  set billingAddressesResponse(ApiResponse response) {
    _billingAddressesResponse = response;
    update();
  }

  ApiResponse get billingAddressesResponse => _billingAddressesResponse;

  void fetchSavedShippingAddresses() {
    // billingAddressesResponse = ApiResponse(data: dummyShippingAddresses);
    // billingAddressesResponse = ApiResponse(error: "Some error");
  }
}
