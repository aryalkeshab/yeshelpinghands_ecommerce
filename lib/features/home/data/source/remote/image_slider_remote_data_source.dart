import '../../../../../core/data/data_source/remote/api_client.dart';
import '../../../../../core/data/data_source/remote/api_constants.dart';

abstract class BannerRemoteDataSource {
  Future<dynamic> getSliderImageList();

  Future<dynamic> getFeaturedCategoryBanners();

  Future<dynamic> getBannerList();

  Future<dynamic> getSingleBanner();
}

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  final ApiClient apiClient;

  BannerRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<dynamic> getSliderImageList() {
    return apiClient.get(APIPathHelper.homeAPIs(APIPath.imageSlider));
  }

  @override
  Future getBannerList() {
    return apiClient.get(APIPathHelper.homeAPIs(APIPath.banners, keyword: "yhh-col-banners"));
  }

  @override
  Future getSingleBanner() {
    return apiClient.get(APIPathHelper.homeAPIs(APIPath.banners, keyword: "yhh-single-banner"));
  }

  @override
  Future getFeaturedCategoryBanners() {
    return apiClient.get(APIPathHelper.homeAPIs(APIPath.banners, keyword: "yhh-slider-banners"));
  }
}
