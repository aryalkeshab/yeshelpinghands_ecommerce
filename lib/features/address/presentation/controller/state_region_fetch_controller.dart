import 'package:get/get.dart';
import 'package:yeshelpinghand/features/address/domain/repository/address_repository.dart';

import '../../../../core/data/data_source/remote/api_result.dart';
import '../../data/model/response/country_region.dart';

class RegionFetchController extends GetxController {
  @override
  onInit() {
    super.onInit();
  }

  ApiResponse _regionListResponse = ApiResponse(data: <CountryRegion>[]);

  set regionListResponse(ApiResponse response) {
    _regionListResponse = response;
    update();
  }

  ApiResponse get regionListResponse => _regionListResponse;

  set countryRegionList(List<CountryRegion> list) {
    _countryRegionList = list;
    update();
  }

  var _countryRegionList = <CountryRegion>[];

  List<CountryRegion> get countryRegionList => _countryRegionList;

  getRegionByCountryId(String id) async {
    regionListResponse =
        await Get.find<AddressRepository>().getRegionByCountryId(id);
    if (regionListResponse.hasData) {
      countryRegionList
        ..clear()
        ..addAll(regionListResponse.data);
    } else if (regionListResponse.hasError) {
      countryRegionList.clear();
    }
  }
}
