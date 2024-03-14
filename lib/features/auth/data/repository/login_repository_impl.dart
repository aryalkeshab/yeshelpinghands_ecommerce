import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/data/data_source/local/storage_constants.dart';
import '../../../../core/data/data_source/remote/api_result.dart';
import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../../core/data/data_source/remote/network_info.dart';
import '../../domain/repository/login_repository.dart';
import '../data_source/remote/login_remote_data_source.dart';
import '../models/request/login_params.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  final NetworkInfo networkInfo;
  final FlutterSecureStorage secureStorage;

  LoginRepositoryImpl({
    required this.loginRemoteDataSource,
    required this.networkInfo,
    required this.secureStorage,
  });

  @override
  Future<ApiResponse> login(LoginParams loginParams) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await loginRemoteDataSource.login(loginParams);

        await secureStorage.write(
            key: StorageConstants.accessToken, value: response["data"]['token']);

        return ApiResponse(data: response['message']);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.badResponse) {
          return ApiResponse(
              error: NetworkException.defaultError(value: e.response?.data['message'] ?? ''));
        }
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
