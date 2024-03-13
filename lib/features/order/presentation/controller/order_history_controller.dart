import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import '../../data/response/order_details.dart';
import '../../domain/repository/order_repository.dart';

class OrderHistoryController extends GetxController {
  @override
  void onInit() {
    fetchOrderList();

    super.onInit();
  }

  String? orderIncrementId;
  ApiResponse _orderHistoryResponse = ApiResponse();

  set orderHistoryResponse(ApiResponse response) {
    _orderHistoryResponse = response;
    update();
  }

  ApiResponse get orderHistoryResponse => _orderHistoryResponse;

  Future<void> fetchOrderList() async {
    orderHistoryResponse = await Get.find<OrderRepository>().getOrderList();
  }

  ApiResponse _orderHistoryDetailsResponse = ApiResponse();

  set orderHistoryDetailsResponse(ApiResponse response) {
    _orderHistoryDetailsResponse = response;
    OrderDetails orderDetails = response.data;
    orderIncrementId = orderDetails.id;
    update();
  }

  ApiResponse get orderHistoryDetailsResponse => _orderHistoryDetailsResponse;

  Future<void> fetchOrderHistoryDetails(String id) async {
    orderHistoryDetailsResponse = await Get.find<OrderRepository>().getOrderDetails(id);
  }
}
