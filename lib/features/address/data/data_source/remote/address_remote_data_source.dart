import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';
import 'package:yeshelpinghand/features/address/data/model/request/address_params.dart';

abstract class AddressRemoteDataSource {
  Future<dynamic> getNonDefaultAddresses();

  Future<dynamic> deleteNonDefaultAddress(String id);

  Future<dynamic> updateNonDefaultAddress(String id, AddressParams addressParams);

  Future<dynamic> addNonDefaultAddress(AddressParams addressParams);
}

class AddressRemoteDataSourceImpl extends AddressRemoteDataSource {
  final ApiClient apiClient;

  AddressRemoteDataSourceImpl({required this.apiClient});

  @override
  Future getNonDefaultAddresses() {
    return apiClient.authGet(APIPathHelper.addressAPIs(APIPath.nonDefaultAddressList));
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
    addressParams.id = id;
    return apiClient.authPut(
        APIPathHelper.addressAPIs(
          APIPath.updateNonDefaultAddress,
        ),
        queryParameters: addressParams.toJson());
  }

  @override
  Future addNonDefaultAddress(AddressParams addressParams) {
    return apiClient.authPost(APIPathHelper.addressAPIs(APIPath.addNonDefaultAddress),
        data: addressParams.toJson());
  }
}
