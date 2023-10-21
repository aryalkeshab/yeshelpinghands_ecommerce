import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/address/data/data_source/remote/address_remote_data_source.dart';
import 'package:yeshelpinghand/features/address/data/repository/address_repository_impl.dart';
import 'package:yeshelpinghand/features/address/domain/repository/address_repository.dart';
import 'package:yeshelpinghand/features/address/presentation/controller/address_controller.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<AddressRemoteDataSource>(
          AddressRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<AddressRepository>(AddressRepositoryImpl(
          addressRemoteDataSource: Get.find<AddressRemoteDataSource>(),
          networkInfo: Get.find<NetworkInfo>()))
      ..put<AddressController>(AddressController());
  }
}
