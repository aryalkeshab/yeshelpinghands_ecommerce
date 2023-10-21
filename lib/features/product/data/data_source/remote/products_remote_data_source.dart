import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';

abstract class ProductRemoteDataSource {
  Future<dynamic> getProductDetails(String sku);

  Future<dynamic> getAllProducts(FilterQueryParams filterQueryParams);

  Future<dynamic> getBestSellingProducts(FilterQueryParams filterQueryParams);

  Future<dynamic> getTopRatedProducts(FilterQueryParams filterQueryParams);

  Future<dynamic> getExclusiveDealsProduct(FilterQueryParams filterQueryParams);

  Future<dynamic> getCashBackOfferProducts(FilterQueryParams filterQueryParams);

  Future<dynamic> getNewArrivalProducts(FilterQueryParams filterQueryParams);

  Future<dynamic> getFilterModel(String id);
}

class ProductsRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<dynamic> getAllProducts(FilterQueryParams filterQueryParams) {
    return apiClient.get(APIPathHelper.productAPIs(APIPath.products),
        queryParameters: filterQueryParams.toJson());
  }

  @override
  Future<dynamic> getBestSellingProducts(FilterQueryParams filterQueryParams) {
    return apiClient.get(APIPathHelper.productAPIs(APIPath.products),
        queryParameters: filterQueryParams.toJson());
  }

  @override
  Future<dynamic> getTopRatedProducts(FilterQueryParams filterQueryParams) {
    return apiClient.get(APIPathHelper.productAPIs(APIPath.products),
        queryParameters: filterQueryParams.toJson());
  }

  @override
  Future<dynamic> getExclusiveDealsProduct(
      FilterQueryParams filterQueryParams) {
    return apiClient.get(APIPathHelper.productAPIs(APIPath.products),
        queryParameters: filterQueryParams.toJson());
  }

  @override
  Future<dynamic> getCashBackOfferProducts(
      FilterQueryParams filterQueryParams) {
    return apiClient.get(APIPathHelper.productAPIs(APIPath.products),
        queryParameters: filterQueryParams.toJson());
  }

  @override
  Future<dynamic> getNewArrivalProducts(FilterQueryParams filterQueryParams) {
    return apiClient.get(APIPathHelper.productAPIs(APIPath.products),
        queryParameters: filterQueryParams.toJson());
  }

  @override
  Future getProductDetails(String sku) {
    return apiClient.authGetWithoutTokenValidation(
      APIPathHelper.productAPIs(
        APIPath.productDetail,
        keyword: sku,
      ),
    );
  }

  @override
  Future getFilterModel(String id) {
    return apiClient.get(
      APIPathHelper.productAPIs(
        APIPath.filterModel,
        id: id,
      ),
    );
  }
}
