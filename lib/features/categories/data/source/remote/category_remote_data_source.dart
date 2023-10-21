import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

abstract class CategoryRemoteDataSource {
  Future<dynamic> getAllCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiClient apiClient;

  CategoryRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<dynamic> getAllCategories() {
    return apiClient.get(APIPathHelper.categoryAPIs(APIPath.category));
  }
}
