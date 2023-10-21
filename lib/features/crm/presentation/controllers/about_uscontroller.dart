import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/crm/domain/repository/crm_repository.dart';
import 'package:get/get.dart';

class AboutUsController extends GetxController {
  late CRMRepository _CRMRepository;
  // bool isLoading = false;

  get data => null;
  @override
  void onInit() {
    _CRMRepository = Get.find<CRMRepository>();

    getAboutUsDetails(5);
    super.onInit();
  }

  ApiResponse _aboutUsApiResponse = ApiResponse();

  set aboutUsApiResponse(ApiResponse response) {
    _aboutUsApiResponse = response;
    update();
  }

  ApiResponse get aboutUsApiResponse => _aboutUsApiResponse;

  getAboutUsDetails(int id) async {
    // isLoading = true;
    aboutUsApiResponse = await _CRMRepository.fetchCrmDetails(id);
    // isLoading = false;
  }
}
