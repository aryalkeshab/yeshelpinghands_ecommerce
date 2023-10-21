import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';

import '../../../../../core/data/data_source/remote/api_constants.dart';

abstract class WishListRemoteDataSource {
  Future<dynamic> getWishList();
  Future<dynamic> postWishList(int id);
  Future<dynamic> removeWishListItem(int id);
  Future<dynamic> clearWishList();
}

class WishListRemoteDataSourceImpl implements WishListRemoteDataSource {
  final ApiClient apiClient;

  WishListRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<dynamic> getWishList() {
    return apiClient.authGet(APIPathHelper.wishListAPIs(APIPath.getWishList));
  }

  @override
  Future<dynamic> postWishList(int id) {
    return apiClient.authPost(
        APIPathHelper.wishListAPIs(APIPath.addItem, id: id.toString()));
  }

  @override
  Future<dynamic> clearWishList() {
    return apiClient.authDelete(APIPathHelper.wishListAPIs(
      APIPath.clear,
    ));
  }

  @override
  Future<dynamic> removeWishListItem(int id) {
    return apiClient.authDelete(
        APIPathHelper.wishListAPIs(APIPath.removeItem, id: id.toString()));
  }
}
