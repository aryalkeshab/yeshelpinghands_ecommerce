import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/store_location/data/data_source/remote/store_pickup_remote_data_source.dart';
import 'package:yeshelpinghand/features/store_location/data/repository/store_pickup_repository_impl.dart';
import 'package:yeshelpinghand/features/store_location/domain/repository/store_pickup_repository.dart';
import 'package:yeshelpinghand/features/store_location/presentation/controllers/store_controller.dart';
import 'package:get/get.dart';

import '../../../core/data/data_source/remote/api_client.dart';

class StorePickupBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<StorePickupRemoteDataSource>(
          StorePickupRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<StorePickupRepository>(StorePickupRepositoryImpl(
          storeLocationRemoteDataSource:
              Get.find<StorePickupRemoteDataSource>(),
          networkInfo: Get.find<NetworkInfo>()))
      ..put<StorePickupController>(StorePickupController());
  }
}
