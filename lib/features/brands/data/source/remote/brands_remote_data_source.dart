import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

abstract class BrandsRemoteDataSource {
  Future<dynamic> getBrandsList();
}

class BrandsRemoteDataSourceImpl implements BrandsRemoteDataSource {
  final ApiClient apiClient;

  BrandsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<dynamic> getBrandsList() {
    return apiClient.get(APIPathHelper.brandsApi(APIPath.brands));
  }
}
