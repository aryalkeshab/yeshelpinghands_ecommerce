import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/home/domain/repository/banner_repository.dart';
import 'package:yeshelpinghand/features/home/domain/repository/home_banner_repository.dart';
import 'package:get/get.dart';

class HomeBannerController extends GetxController {
  late HomeBannerRepository _homeBannerRepository;

  @override
  void onInit() {
    // getBanner1("qmb-col-banners");
    // getBanner2("banner_mid2_home1");

    super.onInit();
    _homeBannerRepository = Get.find<HomeBannerRepository>();
    getBannerList();
    // getSingleBanner();
  }

  //home banner 1
  ApiResponse _homeBanner1ApiResponse = ApiResponse();

  set homeBanner1ApiResponse(ApiResponse response) {
    _homeBanner1ApiResponse = response;
    update();
  }

  ApiResponse get homeBanner1ApiResponse => _homeBanner1ApiResponse;

  getBanner1(String identifier) async {
    homeBanner1ApiResponse =
        await _homeBannerRepository.getBannerList(identifier);
  }

// home banner 2
  ApiResponse _homeBanner2ApiResponse = ApiResponse();

  set homeBanner2ApiResponse(ApiResponse response) {
    _homeBanner2ApiResponse = response;
    update();
  }

  ApiResponse get homeBanner2ApiResponse => _homeBanner2ApiResponse;

  getBanner2(String identifier) async {
    homeBanner2ApiResponse =
        await _homeBannerRepository.getBannerList(identifier);
  }

  ApiResponse _singleBannerResponse = ApiResponse();

  set singleBannerResponse(ApiResponse response) {
    _singleBannerResponse = response;
    update();
  }

  ApiResponse get singleBannerResponse => _singleBannerResponse;

  // getSingleBanner() async {
  //   print("!!!!!!!!!!!!!!!!!!!!!!!");
  //   singleBannerResponse =
  //       await Get.find<BannerRepository>().fetchSingleBanner();
  // }

  ApiResponse _bannerListResponse = ApiResponse();

  set bannerListResponse(ApiResponse response) {
    _bannerListResponse = response;
    update();
  }

  ApiResponse get bannerListResponse => _bannerListResponse;

  getBannerList() async {
    bannerListResponse = await Get.find<BannerRepository>().fetchBannerList();
  }

  getBothBanner() async {
    await getBannerList();
    // await getSingleBanner();
  }
}
