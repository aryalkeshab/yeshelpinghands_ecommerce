import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/crm/domain/repository/crm_repository.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyController extends GetxController {
  late CRMRepository _CRMRepository;
  get data => null;
  @override
  void onInit() {
    _CRMRepository = Get.find<CRMRepository>();

    getPrivacyPolicy(4);
    super.onInit();
  }

  void launchEmail(String emailAddress, String subject) {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': subject,
      },
    );
    launchUrl(emailLaunchUri);
  }

  ApiResponse _privacyPolicyApiResponse = ApiResponse();

  set privacyPolicyAPIResponse(ApiResponse response) {
    _privacyPolicyApiResponse = response;
    update();
  }

  ApiResponse get privacyPolicyAPIResponse => _privacyPolicyApiResponse;

  getPrivacyPolicy(int id) async {
    privacyPolicyAPIResponse = await _CRMRepository.fetchCrmDetails(id);
  }
}
