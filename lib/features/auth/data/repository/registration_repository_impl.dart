import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/auth/data/data_source/remote/register_remote_data_source.dart';
import 'package:yeshelpinghand/features/auth/data/models/request/register_params.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final NetworkInfo networkInfo;
  final RegisterRemoteDataSource registerRemoteDataSource;

  RegisterRepositoryImpl(
      {required this.networkInfo, required this.registerRemoteDataSource});

  @override
  Future<ApiResponse> register(RegisterParams registerParams) async {
    if (await networkInfo.isConnected) {
      try {
        await registerRemoteDataSource.register(registerParams);

        return ApiResponse(data: "Registration successful");
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
