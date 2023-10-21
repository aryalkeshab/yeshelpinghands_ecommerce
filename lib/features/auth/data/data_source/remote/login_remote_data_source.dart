import '../../../../../core/data/data_source/remote/api_client.dart';
import '../../../../../core/data/data_source/remote/api_constants.dart';
import '../../models/request/login_params.dart';

abstract class LoginRemoteDataSource {
  Future<dynamic> login(LoginParams loginParams);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final ApiClient _apiClient;

  LoginRemoteDataSourceImpl(this._apiClient);

  @override
  Future<dynamic> login(LoginParams loginParams) {
    return _apiClient.post(APIPathHelper.authAPIs(APIPath.login),
        data: loginParams.toJson());
  }
}
