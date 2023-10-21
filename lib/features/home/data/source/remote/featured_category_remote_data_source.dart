import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

abstract class FeaturedCategoryRemoteDataSource {
  Future<dynamic> getFeaturedCategory();
}

class FeaturedCategoryRemoteDataSourceImpl
    implements FeaturedCategoryRemoteDataSource {
  final ApiClient apiClient;

  FeaturedCategoryRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<dynamic> getFeaturedCategory() {
    return apiClient.get(APIPathHelper.homeAPIs(APIPath.featuredCategory));
  }
}
