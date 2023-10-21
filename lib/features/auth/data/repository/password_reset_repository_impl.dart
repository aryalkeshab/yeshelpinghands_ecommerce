import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/auth/data/data_source/remote/password_reset_remote_data_source.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/password_reset_repository.dart';

class PasswordResetRepositoryImpl implements PasswordResetRepository {
  final PasswordResetRemoteDataSource passwordResetRemoteDataSource;
  final NetworkInfo networkInfo;

  PasswordResetRepositoryImpl({
    required this.passwordResetRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<ApiResponse> resetPassword({required String email}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await passwordResetRemoteDataSource.resetPassword(email: email);
        return ApiResponse(
            data: "Password reset link has been sent to your email");
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.badResponse) {
          return ApiResponse(
              error: NetworkException.defaultError(
                  value: e.response?.data['message'] ?? ''));
        }
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
