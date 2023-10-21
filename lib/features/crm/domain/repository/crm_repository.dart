import '../../../../core/data/data_source/remote/api_result.dart';

abstract class CRMRepository {
  Future<ApiResponse> fetchCrmDetails(int id);
}
