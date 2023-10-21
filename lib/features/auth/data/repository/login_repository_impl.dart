import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yeshelpinghand/features/auth/data/data_source/remote/social_login_data_source.dart';

import '../../../../core/data/data_source/local/storage_constants.dart';
import '../../../../core/data/data_source/remote/api_result.dart';
import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../../core/data/data_source/remote/network_info.dart';
import '../../domain/repository/login_repository.dart';
import '../data_source/remote/login_remote_data_source.dart';
import '../models/request/login_params.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  final SocialLoginDataSource socialLoginDataSource;
  final NetworkInfo networkInfo;
  final FlutterSecureStorage secureStorage;

  LoginRepositoryImpl({
    required this.loginRemoteDataSource,
    required this.networkInfo,
    required this.secureStorage,
    required this.socialLoginDataSource,
  });

  @override
  Future<ApiResponse> login(LoginParams loginParams) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await loginRemoteDataSource.login(loginParams);

        await secureStorage.write(
            key: StorageConstants.accessToken, value: response[0]['token']);

        return ApiResponse(data: response[0]['message']);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.badResponse) {
          print(e.response?.data);
          return ApiResponse(
              error: NetworkException.defaultError(
                  value: e.response?.data[0]['message']));
        }
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> loginWithGoogle() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await socialLoginDataSource.loginWithGoogle();

        await secureStorage.write(
            key: StorageConstants.accessToken, value: response[0]['token']);
        await secureStorage.write(
            key: StorageConstants.socialLoginType, value: "GOOGLE");

        return ApiResponse(data: response[0]['message']);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.badResponse) {
          print(e.response?.data);
          return ApiResponse(
              error: NetworkException.defaultError(
                  value: e.response?.data[0]['message']));
        } else if (e is SocialLoginException) {
          return ApiResponse(
              error: NetworkException.defaultError(value: e.message));
        } else {
          return ApiResponse(
              error: NetworkException.defaultError(value: e.toString()));
        }
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> loginWithFacebook() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await socialLoginDataSource.loginWithFacebook();

        await secureStorage.write(
            key: StorageConstants.accessToken, value: response[0]['token']);
        await secureStorage.write(
            key: StorageConstants.socialLoginType, value: "FACEBOOK");
        return ApiResponse(data: response[0]['message']);
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.badResponse) {
          return ApiResponse(
              error: NetworkException.defaultError(
                  value: e.response?.data[0]['message']));
        }
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
