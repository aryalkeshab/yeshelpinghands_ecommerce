import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';
import 'package:yeshelpinghand/features/auth/data/models/request/update_password_params.dart';

abstract class PasswordUpdateRemoteDataSource {
  Future<dynamic> updatePassword(UpdatePasswordParams updatePasswordParams);
}

class PasswordUpdateRemoteDataSourceImpl
    implements PasswordUpdateRemoteDataSource {
  final ApiClient apiClient;

  PasswordUpdateRemoteDataSourceImpl({required this.apiClient});

  @override
  Future updatePassword(UpdatePasswordParams updatePasswordParams) {
    return apiClient.authPut(APIPathHelper.authAPIs(APIPath.passwordUpdate),
        data: updatePasswordParams.toJson());
  }
}
