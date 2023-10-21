import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';
import 'package:yeshelpinghand/features/auth/data/models/request/register_params.dart';

abstract class RegisterRemoteDataSource {
  Future<dynamic> register(RegisterParams registerParams);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final ApiClient apiClient;

  RegisterRemoteDataSourceImpl({required this.apiClient});

  @override
  Future register(RegisterParams registerParams) {
    return apiClient.validatedPost(APIPathHelper.authAPIs(APIPath.register),
        data: registerParams.toJson());
  }
}
