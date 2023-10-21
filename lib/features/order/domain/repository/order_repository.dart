import '../../../../core/data/data_source/remote/api_result.dart';

abstract class OrderRepository {
  Future<ApiResponse> getOrderList();

  Future<ApiResponse> getOrderDetails(String id);
}
