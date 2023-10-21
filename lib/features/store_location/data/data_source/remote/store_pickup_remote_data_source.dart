import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

abstract class StorePickupRemoteDataSource {
  Future<dynamic> getStorePickupList();
}

class StorePickupRemoteDataSourceImpl extends StorePickupRemoteDataSource {
  final ApiClient apiClient;

  StorePickupRemoteDataSourceImpl({required this.apiClient});

  @override
  Future getStorePickupList() {
    return apiClient
        .authGet(APIPathHelper.storeLocationAPIs(APIPath.pickupStoreList));
  }
}
