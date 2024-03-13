import 'package:get/get.dart';
import '../../../../core/data/data_source/remote/api_result.dart';

class CountryFetchController extends GetxController {
  @override
  onInit() {
    super.onInit();
    // getCountryList();
  }

  ApiResponse _countryListResponse = ApiResponse();

  set countryListResponse(ApiResponse response) {
    _countryListResponse = response;
    update();
  }

  ApiResponse get countryListResponse => _countryListResponse;

  // getCountryList() async {
  //   countryListResponse = await Get.find<AddressRepository>().getCountryList();
  // }
}
