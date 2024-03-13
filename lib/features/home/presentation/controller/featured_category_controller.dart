import 'package:get/get.dart';
import '../../../../core/data/data_source/remote/api_result.dart';
import '../../domain/repository/banner_repository.dart';

class FeaturedCategoryController extends GetxController {
  @override
  onInit() {
    super.onInit();
    fetchFeaturedCategoryBanners();
  }

  //hot deals
  ApiResponse _featuredCategoryApiResponse = ApiResponse();

  set featuredCategoryApiResponse(ApiResponse response) {
    _featuredCategoryApiResponse = response;
    update();
  }

  ApiResponse get featuredCategoryApiResponse => _featuredCategoryApiResponse;

  fetchFeaturedCategoryBanners() async {
    featuredCategoryApiResponse = await Get.find<BannerRepository>().fetchFeaturedCategoryBanner();
  }
}
