import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/wishlist/data/model/wishlist.dart';
import 'package:yeshelpinghand/features/wishlist/domain/repository/wishList_repository.dart';
import 'package:dio/dio.dart';

import '../source/remote/wishlist_remote_data_source.dart';

class WishListRepositoryImpl implements WishListRepository {
  final WishListRemoteDataSource wishListRemoteDataSource;
  final NetworkInfo networkInfo;

  WishListRepositoryImpl(
      {required this.networkInfo, required this.wishListRemoteDataSource});

  @override
  Future<ApiResponse> getAllWishListProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await wishListRemoteDataSource.getWishList();
        if (result.isEmpty) {
          return ApiResponse(data: <WishListProduct>[]);
        } else {
          final wishList = result["data"]
              .map<WishListProduct>((e) => WishListProduct.fromJson(e))
              .toList();
          return ApiResponse(data: wishList);
        }
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> removeWishList(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await wishListRemoteDataSource.removeWishListItem(id);

        return ApiResponse(data: 'Successfully Removed from Wishlist');
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> clearWishList() async {
    if (await networkInfo.isConnected) {
      try {
        await wishListRemoteDataSource.clearWishList();

        return ApiResponse(data: 'Successfully Removed Products from Wishlist');
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> postWishList(String slug) async {
    if (await networkInfo.isConnected) {
      try {
        await wishListRemoteDataSource.postWishList(slug);

        return ApiResponse(data: 'Successfully Added to Wishlist');
      } catch (e) {
        if (e is DioError && e.type == DioErrorType.badResponse) {
          return ApiResponse(
              error: NetworkException.defaultError(
                  value: e.response?.data['error'] ?? ''));
        }
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
