import '../../../../../core/data/data_source/remote/api_result.dart';
import '../../data/model/request/edit_profile_params.dart';

abstract class ProfileRepository {
  Future<ApiResponse> fetchProfileDetails();
  Future<ApiResponse> editProfile(EditProfileParams editProfileParams);
}