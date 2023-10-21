import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

abstract class HomeBannerRemoteDataSource {
  Future<dynamic> getBannerList(String identifier);
}

class HomeBannerRemoteDataSourceImpl implements HomeBannerRemoteDataSource {
  final ApiClient apiClient;

  HomeBannerRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<dynamic> getBannerList(String identifier) {
    return apiClient
        .get(APIPathHelper.homeAPIs(APIPath.banners, keyword: identifier));
  }
}
