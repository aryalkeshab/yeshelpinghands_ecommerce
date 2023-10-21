import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

import '../../../../../core/data/data_source/remote/api_client.dart';

abstract class CompareProductRemoteDataSource {
  Future<dynamic> getCompareProductList(List<String> productIds);

  Future<dynamic> deleteCompareProduct(String id);

  Future<dynamic> addToCompareProduct(String id);
}

class CompareProductRemoteDataSourceImpl
    implements CompareProductRemoteDataSource {
  final ApiClient apiClient;

  CompareProductRemoteDataSourceImpl({required this.apiClient});

  @override
  Future getCompareProductList(List<String> productIds) {
    return apiClient.authGet(APIPathHelper.productAPIs(APIPath.productCompare),
        queryParameters: {"id": productIds});
  }

  @override
  Future deleteCompareProduct(String id) {
    return apiClient.authDelete(
      APIPathHelper.productAPIs(APIPath.deleteCompareProduct,
          id: id.toString()),
    );
  }

  @override
  Future addToCompareProduct(String id) {
    return apiClient.authPost(
      APIPathHelper.productAPIs(APIPath.addCompareProduct, id: id.toString()),
    );
  }
}
