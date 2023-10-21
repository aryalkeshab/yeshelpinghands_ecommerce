import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/crm/data/repository/crm_repository_implementation.dart';
import 'package:yeshelpinghand/features/crm/data/source/remote/crm_remote_data_source.dart';
import 'package:yeshelpinghand/features/crm/domain/repository/crm_repository.dart';
import 'package:get/get.dart';

import '../../../core/data/data_source/remote/api_client.dart';

class CRMBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<CRMRemoteDataSource>(
          CRMRemoteDataSourceImpl(client: Get.find<ApiClient>()))
      ..put<CRMRepository>(CRMRepositoryImpl(
          networkInfo: Get.find<NetworkInfo>(),
          crmRemoteDataSource: Get.find<CRMRemoteDataSource>()));
  }
}
