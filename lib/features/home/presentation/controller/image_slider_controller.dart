import 'package:get/get.dart';
import 'package:yeshelpinghand/features/home/domain/repository/banner_repository.dart';

import '../../../../core/data/data_source/remote/api_result.dart';

class ImageSliderController extends GetxController {
  @override
  onInit() {
    super.onInit();
    fetchImageSlider();
  }

  ApiResponse _imageSliderResponse = ApiResponse();

  set imageSliderResponse(ApiResponse apiResponse) {
    _imageSliderResponse = apiResponse;
    update();
  }

  ApiResponse get imageSliderResponse => _imageSliderResponse;

  fetchImageSlider() async {
    imageSliderResponse =
        await Get.find<BannerRepository>().fetchSliderImageList();
  }
}
