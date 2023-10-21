import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/brands/domain/repository/brands_repository.dart';

class BrandsController extends GetxController {
  @override
  onInit() {
    super.onInit();
    fetchBrandsList();
  }

  ApiResponse _brandsApiResponse = ApiResponse();

  set brandsApiResponse(ApiResponse response) {
    _brandsApiResponse = response;
    update();
  }

  ApiResponse get brandsApiResponse => _brandsApiResponse;

  fetchBrandsList() async {
    brandsApiResponse = await Get.find<BrandsRepository>().getBrandsList();
  }
}
