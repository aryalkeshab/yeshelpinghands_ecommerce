import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';
import 'package:yeshelpinghand/features/address/data/model/request/address_params.dart';
import 'package:yeshelpinghand/features/address/data/model/response/address.dart';

import '../../../presentation/utils/address_type_enum.dart';

abstract class AddressRemoteDataSource {
  Future<dynamic> getNonDefaultAddresses();

  Future<dynamic> deleteNonDefaultAddress(String id);

  Future<dynamic> updateNonDefaultAddress(
      String id, AddressParams addressParams);

  Future<dynamic> addNonDefaultAddress(AddressParams addressParams);

  // Future<dynamic> getDefaultAddresses();

  // Future<dynamic> updateDefaultShippingAddress(AddressParams addressParams);

  // Future<dynamic> updateDefaultBillingAddress(AddressParams addressParams);

  // Future<dynamic> setDefaultShippingAddress(
  //   String id,
  // );

  // Future<dynamic> setDefaultBillingAddress(
  //   String id,
  // );

  // Future<dynamic> getCountryList();

  // Future<dynamic> getRegionByCountryId(String id);
}

class AddressRemoteDataSourceImpl extends AddressRemoteDataSource {
  final ApiClient apiClient;

  AddressRemoteDataSourceImpl({required this.apiClient});

  @override
  Future getNonDefaultAddresses() {
    return apiClient
        .authGet(APIPathHelper.addressAPIs(APIPath.nonDefaultAddressList));
  }

  @override
  Future deleteNonDefaultAddress(String id) {
    return apiClient.authDelete(
      APIPathHelper.addressAPIs(
        APIPath.deleteNonDefaultAddress,
      ),
      queryParameters: {"id": id},
    );
  }

  @override
  Future updateNonDefaultAddress(String id, AddressParams addressParams) {
    return apiClient.authPut(
        APIPathHelper.addressAPIs(APIPath.updateNonDefaultAddress, id: id),
        data: addressParams.toJson());
  }

  @override
  Future addNonDefaultAddress(AddressParams addressParams) {
    return apiClient.authPost(
        APIPathHelper.addressAPIs(APIPath.addNonDefaultAddress),
        data: addressParams.toJson());
  }

  // @override
  // Future getDefaultAddresses() {
  //   return apiClient.authGet(APIPathHelper.addressAPIs(APIPath.defaultAddress));
  // }

  // @override
  // Future updateDefaultShippingAddress(AddressParams addressParams) {
  //   return apiClient.authPut(
  //       APIPathHelper.addressAPIs(APIPath.updateDefaultShippingAddress),
  //       data: addressParams.toJson());
  // }

  // @override
  // Future updateDefaultBillingAddress(AddressParams addressParams) {
  //   return apiClient.authPut(
  //       APIPathHelper.addressAPIs(APIPath.updateDefaultBillingAddress),
  //       data: addressParams.toJson());
  // }

  // @override
  // Future setDefaultBillingAddress(String id) {
  //   return apiClient.authPut(
  //       APIPathHelper.addressAPIs(APIPath.setDefaultBillingAddress, id: id));
  // }

  // @override
  // Future setDefaultShippingAddress(String id) {
  //   return apiClient.authPut(
  //       APIPathHelper.addressAPIs(APIPath.setDefaultShippingAddress, id: id));
  // }

  // @override
  // Future getCountryList() {
  //   return apiClient.get(APIPathHelper.addressAPIs(APIPath.countryList));
  // }

  // @override
  // Future getRegionByCountryId(String id) {
  //   return apiClient.get(APIPathHelper.addressAPIs(APIPath.regionList, id: id));
  // }
}
