import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/crm/domain/repository/crm_repository.dart';
import 'package:get/get.dart';

class HelpFaqsController extends GetxController {
  late CRMRepository _CRMRepository;

  get data => null;
  @override
  void onInit() {
    _CRMRepository = Get.find<CRMRepository>();

    getHelpFaqDetails(9);
    super.onInit();
  }

  ApiResponse _helpAndFaqsApiResponse = ApiResponse();

  set helpAndFaqsApiResponse(ApiResponse response) {
    _helpAndFaqsApiResponse = response;
    update();
  }

  ApiResponse get helpAndFaqsApiResponse => _helpAndFaqsApiResponse;

  getHelpFaqDetails(int id) async {
    helpAndFaqsApiResponse = await _CRMRepository.fetchCrmDetails(id);
  }
}
