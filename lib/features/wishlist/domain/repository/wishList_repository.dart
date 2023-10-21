import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';

abstract class WishListRepository {
  Future<ApiResponse> getAllWishListProducts();
  Future<ApiResponse> postWishList(int id);
  Future<ApiResponse> removeWishList(int id);
  Future<ApiResponse> clearWishList();
}
