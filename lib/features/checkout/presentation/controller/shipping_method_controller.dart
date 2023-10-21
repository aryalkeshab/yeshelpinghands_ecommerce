import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/checkout/domain/repository/checkout_repository.dart';
import 'package:get/get.dart';

class ShippingMethodController extends GetxController {
  @override
  void onInit() {
    fetchShippingMethods();
    super.onInit();
  }

  ApiResponse _shippingMethodsResponse = ApiResponse();

  set shippingMethodsResponse(ApiResponse response) {
    _shippingMethodsResponse = response;
    update();
  }

  ApiResponse get shippingMethodsResponse => _shippingMethodsResponse;

  fetchShippingMethods() async {
    shippingMethodsResponse =
        await Get.find<CheckoutRepository>().fetchShippingMethods();
  }
}
