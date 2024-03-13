import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';

abstract class ProductsRepository {
  Future<ApiResponse> getProductDetails(String sku);

  Future<ApiResponse> getAllProducts(FilterQueryParams filterQueryParams);

  Future<ApiResponse> getBestSellingProducts(FilterQueryParams filterQueryParams);

  Future<ApiResponse> fetchTopRatedProducts(FilterQueryParams filterQueryParams);

  Future<ApiResponse> getExclusiveDealsProduct(FilterQueryParams filterQueryParams);

  Future<ApiResponse> getCashBackOfferProducts(FilterQueryParams filterQueryParams);

  Future<ApiResponse> getNewArrivalProducts(FilterQueryParams filterQueryParams);
}
