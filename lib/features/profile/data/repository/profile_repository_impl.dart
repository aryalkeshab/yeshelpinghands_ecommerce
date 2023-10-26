import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/profile/domain/repository/profile_repository.dart';
import 'package:dio/dio.dart';

import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../../core/data/data_source/remote/network_info.dart';

import '../data_source/remote/profile_remote_data_source.dart';
import '../model/request/edit_profile_params.dart';
import '../model/response/user.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final NetworkInfo networkInfo;
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl(
      {required this.networkInfo, required this.profileRemoteDataSource});
  @override
  Future<ApiResponse> fetchProfileDetails() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await profileRemoteDataSource.getProfileDetails();

        final profileData = User.fromJson(result["data"]);
        return ApiResponse(data: profileData);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> editProfile(EditProfileParams editProfileParams) async {
    if (await networkInfo.isConnected) {
      try {
        await profileRemoteDataSource.editProfile(editProfileParams);
        return ApiResponse(data: "Successfully Updated");
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
