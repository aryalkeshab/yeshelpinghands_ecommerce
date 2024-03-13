import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/crm/domain/repository/crm_repository.dart';
import 'package:get/get.dart';

class TermsAndConditionsController extends GetxController {
  late CRMRepository _crmRepository;

  get data => null;
  @override
  void onInit() {
    _crmRepository = Get.find<CRMRepository>();

    getTermsAndConditionsDetails(10);
    super.onInit();
  }

  ApiResponse _termsAndConditionsApiResponse = ApiResponse();

  set termsAndConditionsApiResponse(ApiResponse response) {
    _termsAndConditionsApiResponse = response;
    update();
  }

  ApiResponse get termsAndConditionsApiResponse => _termsAndConditionsApiResponse;

  getTermsAndConditionsDetails(int id) async {
    termsAndConditionsApiResponse = await _crmRepository.fetchCrmDetails(id);
  }
}
