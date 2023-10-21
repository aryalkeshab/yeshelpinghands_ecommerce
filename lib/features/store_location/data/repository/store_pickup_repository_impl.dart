import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/store_location/data/data_source/remote/store_pickup_remote_data_source.dart';
import 'package:yeshelpinghand/features/store_location/data/model/pickup_store.dart';
import 'package:yeshelpinghand/features/store_location/data/model/store_model.dart';
import 'package:yeshelpinghand/features/store_location/domain/repository/store_pickup_repository.dart';

import '../../../../core/data/data_source/remote/network_exception.dart';

class StorePickupRepositoryImpl implements StorePickupRepository {
  final StorePickupRemoteDataSource storeLocationRemoteDataSource;
  final NetworkInfo networkInfo;

  StorePickupRepositoryImpl(
      {required this.storeLocationRemoteDataSource, required this.networkInfo});

  @override
  Future<ApiResponse> fetchStorePickupList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await storeLocationRemoteDataSource.getStorePickupList();
        final storePickupList =
            result.map<PickupStore>((e) => PickupStore.fromJson(e)).toList();
        return ApiResponse(data: storePickupList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }
}
