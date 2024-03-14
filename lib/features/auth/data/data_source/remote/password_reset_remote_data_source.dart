import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

abstract class PasswordResetRemoteDataSource {
  Future<dynamic> resetPassword({required String email});
}

class PasswordResetRemoteDataSourceImpl implements PasswordResetRemoteDataSource {
  final ApiClient apiClient;

  PasswordResetRemoteDataSourceImpl({required this.apiClient});

  @override
  Future resetPassword({required String email}) {
    return apiClient.post(
      APIPathHelper.authAPIs(APIPath.passwordReset),
      data: {
        "email": email,
        "template": "email_reset",
      },
    );
  }
}
