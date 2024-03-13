import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/crm/data/models/crm_models.dart';
import 'package:yeshelpinghand/features/crm/domain/repository/crm_repository.dart';

import '../source/remote/crm_remote_data_source.dart';

class CRMRepositoryImpl implements CRMRepository {
  final NetworkInfo networkInfo;
  final CRMRemoteDataSource crmRemoteDataSource;

  CRMRepositoryImpl({required this.networkInfo, required this.crmRemoteDataSource});
  @override
  Future<ApiResponse> fetchCrmDetails(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await crmRemoteDataSource.getCRMDescription(id);
        final crmData = CRMModels.fromJson(result);

        return ApiResponse(data: crmData);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
