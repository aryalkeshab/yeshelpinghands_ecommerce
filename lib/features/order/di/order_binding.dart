import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/order/data/data_source/remote/order_remote_data_source.dart';
import 'package:yeshelpinghand/features/order/data/repository/order_repository_impl.dart';
import 'package:yeshelpinghand/features/order/domain/repository/order_repository.dart';
import 'package:yeshelpinghand/features/order/presentation/controller/order_history_controller.dart';
import 'package:get/get.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<OrderRemoteDataSource>(
          OrderRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<OrderRepository>(OrderRepositoryImpl(
          orderRemoteDataSource: Get.find<OrderRemoteDataSource>(),
          networkInfo: Get.find<NetworkInfo>()))
      ..put<OrderHistoryController>(OrderHistoryController());
  }
}
