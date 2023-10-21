import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/auth/data/data_source/remote/password_update_remote_data_source.dart';
import 'package:yeshelpinghand/features/auth/data/models/request/update_password_params.dart';
import 'package:yeshelpinghand/features/auth/domain/repository/password_update_repository.dart';
import 'package:dio/dio.dart';

class PasswordUpdateRepositoryImpl implements PasswordUpdateRepository {
  final NetworkInfo networkInfo;
  final PasswordUpdateRemoteDataSource passwordUpdateRemoteDataSource;

  PasswordUpdateRepositoryImpl(
      {required this.networkInfo,
      required this.passwordUpdateRemoteDataSource});

  @override
  Future updatePassword(UpdatePasswordParams updatePasswordParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await passwordUpdateRemoteDataSource
            .updatePassword(updatePasswordParams);
        return ApiResponse(
            data:
                "Password updated successful. You can login with your new password");
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.badResponse) {
          return ApiResponse(
              error: NetworkException.defaultError(
                  value: "${e.response?.data["message"]}"));
        }
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
