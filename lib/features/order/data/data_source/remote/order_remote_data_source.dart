import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

abstract class OrderRemoteDataSource {
  Future<dynamic> getOrderList();
  Future<dynamic> getOrderDetails(String id);
}

class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {
  final ApiClient apiClient;

  OrderRemoteDataSourceImpl({required this.apiClient});

  @override
  Future getOrderList() {
    return apiClient.authGet(
      APIPathHelper.orderHistory(APIPath.orders),
    );
  }

  @override
  Future getOrderDetails(String id) {
    return apiClient
        .authGet(APIPathHelper.orderHistory(APIPath.orderDetails, id: id));
  }
}
