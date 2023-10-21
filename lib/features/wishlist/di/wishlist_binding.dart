import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/wishlist/data/repository/wishlist_repository_impl.dart';
import 'package:yeshelpinghand/features/wishlist/domain/repository/wishList_repository.dart';
import 'package:yeshelpinghand/features/wishlist/presentation/controller/wishlist_controller.dart';
import 'package:get/get.dart';

import '../data/source/remote/wishlist_remote_data_source.dart';

class WishListBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<WishListRemoteDataSource>(
          WishListRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<WishListRepository>(WishListRepositoryImpl(
          networkInfo: Get.find<NetworkInfo>(),
          wishListRemoteDataSource: Get.find<WishListRemoteDataSource>()))
      ..put(WishListController());
  }
}
