import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/features/profile/data/repository/profile_repository_impl.dart';
import 'package:yeshelpinghand/features/profile/domain/repository/profile_repository.dart';
import 'package:get/get.dart';

import '../../../core/data/data_source/remote/network_info.dart';
import '../data/data_source/remote/profile_remote_data_source.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<ProfileRemoteDataSource>(
          ProfileRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<ProfileRepository>(ProfileRepositoryImpl(
          networkInfo: Get.find<NetworkInfo>(),
          profileRemoteDataSource: Get.find<ProfileRemoteDataSource>()));
  }
}
