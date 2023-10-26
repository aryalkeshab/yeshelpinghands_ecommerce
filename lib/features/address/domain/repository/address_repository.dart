import 'package:yeshelpinghand/features/address/data/model/request/address_params.dart';

import '../../../../core/data/data_source/remote/api_result.dart';

abstract class AddressRepository {
  Future<ApiResponse> getNonDefaultAddresses();
  Future<ApiResponse> deleteNonDefaultAddress(String id);
  Future<ApiResponse> updateNonDefaultAddress(
      String id, AddressParams addressParams);
  Future<ApiResponse> addNonDefaultAddress(AddressParams addressParams);
  // Future<ApiResponse> getDefaultAddresses();
  // Future<ApiResponse> updateDefaultShippingAddress(AddressParams addressParams);
  // Future<ApiResponse> updateDefaultBillingAddress(AddressParams addressParams);
  // Future<ApiResponse> setDefaultShippingAddress(String id);
  // Future<ApiResponse> setDefaultBillingAddress(String id);
  // Future<ApiResponse> getCountryList();
  // Future<ApiResponse> getRegionByCountryId(String id);
}
