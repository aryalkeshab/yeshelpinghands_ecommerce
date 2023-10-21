import '../../../../core/data/data_source/remote/api_result.dart';
import '../../data/model/compare_product_local_params.dart';

abstract class CompareProductRepository {

  Future<ApiResponse> getProductsFromCompareList();
  Future<ApiResponse> getCompareProductList();

  Future<ApiResponse> deleteCompareProduct(String id);

  Future<ApiResponse> addToCompareProduct(CompareProductLocalParams compareProductLocalParams);
}
