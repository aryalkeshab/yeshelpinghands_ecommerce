import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';

import '../../../../../core/data/data_source/remote/api_constants.dart';

abstract class WishListRemoteDataSource {
  Future<dynamic> getWishList();
  Future<dynamic> postWishList(String slug);
  Future<dynamic> removeWishListItem(String id);
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
  Future<dynamic> postWishList(String slug) {
    return apiClient.authPost(
      APIPathHelper.wishListAPIs(
        APIPath.addItem,
      ),
      data: {
        "slug": slug,
      },
    );
  }

  @override
  Future<dynamic> clearWishList() {
    return apiClient.authGet(APIPathHelper.wishListAPIs(
      APIPath.clear,
    ));
  }

  @override
  Future<dynamic> removeWishListItem(String id) {
    return apiClient.authPost(
        APIPathHelper.wishListAPIs(
          APIPath.addItem,
        ),
        data: {"slug": id});
  }
}
