import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';

abstract class WishListRepository {
  Future<ApiResponse> getAllWishListProducts();
  Future<ApiResponse> postWishList(String slug);
  Future<ApiResponse> removeWishList(String sku);
  Future<ApiResponse> clearWishList();
}
