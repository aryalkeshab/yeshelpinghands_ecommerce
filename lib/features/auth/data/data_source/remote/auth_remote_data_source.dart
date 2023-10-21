import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

abstract class AuthRemoteDataSource {
  Future<dynamic> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<dynamic> logout() {
    return apiClient.authPost(APIPathHelper.authAPIs(APIPath.logout));
  }
}
