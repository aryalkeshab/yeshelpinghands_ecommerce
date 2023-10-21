import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/order/data/data_source/remote/order_remote_data_source.dart';
import 'package:yeshelpinghand/features/order/data/response/order.dart';
import 'package:yeshelpinghand/features/order/data/response/order_details.dart';
import 'package:yeshelpinghand/features/order/domain/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl(
      {required this.orderRemoteDataSource, required this.networkInfo});

  @override
  Future<ApiResponse> getOrderList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await orderRemoteDataSource.getOrderList();
        final orderList = result.map<Order>((e) => Order.fromJson(e)).toList();
        return ApiResponse(data: orderList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }

  @override
  Future<ApiResponse> getOrderDetails(String id) async {
    if (await networkInfo.isConnected) {
      final result = await orderRemoteDataSource.getOrderDetails(id);
      final orderDetails = OrderDetails.fromJson(result[0]);
      return ApiResponse(data: orderDetails);
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }
}
