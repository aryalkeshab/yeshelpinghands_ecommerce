import '../../../../core/data/data_source/remote/api_result.dart';

abstract class BannerRepository {
  Future<ApiResponse> fetchSliderImageList();
  Future<ApiResponse> fetchBannerList();
  Future<ApiResponse> fetchSingleBanner();
  Future<ApiResponse> fetchFeaturedCategoryBanner();
}
