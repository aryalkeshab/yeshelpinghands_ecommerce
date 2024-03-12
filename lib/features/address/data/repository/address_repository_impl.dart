import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/address/data/data_source/remote/address_remote_data_source.dart';
import 'package:yeshelpinghand/features/address/data/model/request/address_params.dart';
import 'package:yeshelpinghand/features/address/data/model/response/address.dart';
import 'package:yeshelpinghand/features/address/domain/repository/address_repository.dart';
import '../../../../core/data/data_source/remote/api_result.dart';
import '../../../../core/data/data_source/remote/network_exception.dart';

class AddressRepositoryImpl extends AddressRepository {
  final AddressRemoteDataSource addressRemoteDataSource;
  final NetworkInfo networkInfo;

  AddressRepositoryImpl({required this.addressRemoteDataSource, required this.networkInfo});

  @override
  Future<ApiResponse> getNonDefaultAddresses() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await addressRemoteDataSource.getNonDefaultAddresses();

        final addressList = result["data"].map<Address>((e) => Address.fromJson(e)).toList();

        return ApiResponse(data: addressList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    }
    return ApiResponse(error: NetworkException.noInternetConnection());
  }

  @override
  Future<ApiResponse> deleteNonDefaultAddress(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await addressRemoteDataSource.deleteNonDefaultAddress(id);
        return ApiResponse(data: result["message"]);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> updateNonDefaultAddress(String id, AddressParams addressParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await addressRemoteDataSource.updateNonDefaultAddress(id, addressParams);
        return ApiResponse(data: result["message"]);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> addNonDefaultAddress(AddressParams addressParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await addressRemoteDataSource.addNonDefaultAddress(addressParams);
        return ApiResponse(data: result["message"]);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
