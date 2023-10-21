import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/auth/data/data_source/remote/register_remote_data_source.dart';
import 'package:yeshelpinghand/features/auth/data/repository/registration_repository_impl.dart';
import 'package:yeshelpinghand/features/auth/domain/repository/register_repository.dart';
import 'package:get/get.dart';

import '../presentation/controller/register_controller.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<RegisterRemoteDataSource>(
          RegisterRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<RegisterRepository>(RegisterRepositoryImpl(
          networkInfo: Get.find<NetworkInfo>(),
          registerRemoteDataSource: Get.find<RegisterRemoteDataSource>()))
      ..put(RegisterController());
  }
}
