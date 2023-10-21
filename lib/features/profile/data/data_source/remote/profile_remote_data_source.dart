import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

import '../../model/request/edit_profile_params.dart';

abstract class ProfileRemoteDataSource {
  Future<dynamic> getProfileDetails();
  Future<dynamic> editProfile(EditProfileParams editProfileParams);
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSourceImpl({required this.apiClient});

  @override
  Future getProfileDetails() {
    return apiClient.authGet(APIPathHelper.profileAPIs(APIPath.profileAPis));
  }

  @override
  Future<dynamic> editProfile(EditProfileParams editProfileParams) async {
    return apiClient.authPut(APIPathHelper.profileAPIs(APIPath.editProfile),
        data: editProfileParams.toJson());
  }
}
