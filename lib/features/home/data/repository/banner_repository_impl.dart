import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';

import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../../core/data/data_source/remote/network_info.dart';
import '../../domain/repository/banner_repository.dart';
import '../models/request/image_slider_response.dart';
import '../source/remote/image_slider_remote_data_source.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource bannerRemoteDataSource;
  final NetworkInfo networkInfo;

  BannerRepositoryImpl({
    required this.bannerRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<ApiResponse> fetchBannerList() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await bannerRemoteDataSource.getBannerList();
        final mappedHomeBanner =
            response["data"].map((e) => AdBannerResponse.fromJson(e)).toList();
        return ApiResponse(data: mappedHomeBanner);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> fetchSliderImageList() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await bannerRemoteDataSource.getSliderImageList();
        final mappedImageSlider =
            response['data'].map((e) => BannerResponse.fromJson(e)).toList();
        return ApiResponse(data: mappedImageSlider);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> fetchSingleBanner() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await bannerRemoteDataSource.getSingleBanner();
        final banner = BannerResponse.fromJson(response[0]);

        return ApiResponse(data: banner);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> fetchFeaturedCategoryBanner() async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await bannerRemoteDataSource.getFeaturedCategoryBanners();
        final mappedImageSlider =
            response["data"].map((e) => BannerResponse.fromJson(e)).toList();
        return ApiResponse(data: mappedImageSlider);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
