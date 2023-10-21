import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

abstract class CRMRemoteDataSource {
  Future<dynamic> getCRMDescription(int id);
}

class CRMRemoteDataSourceImpl implements CRMRemoteDataSource {
  final ApiClient client;

  CRMRemoteDataSourceImpl({required this.client});

  @override
  Future<dynamic> getCRMDescription(int id) {
    return client.get(APIPathHelper.crmAPIs(APIPath.crm, id: "$id"));
  }
}
