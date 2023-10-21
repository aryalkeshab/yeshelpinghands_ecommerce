import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/auth/data/data_source/remote/password_update_remote_data_source.dart';
import 'package:yeshelpinghand/features/auth/domain/repository/password_update_repository.dart';
import 'package:yeshelpinghand/features/auth/presentation/controller/password_update_controller.dart';
import 'package:get/get.dart';

import '../data/repository/password_update_repsository_impl.dart';

class PasswordUpdateBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<PasswordUpdateRemoteDataSource>(
          PasswordUpdateRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<PasswordUpdateRepository>(PasswordUpdateRepositoryImpl(
        networkInfo: Get.find<NetworkInfo>(),
        passwordUpdateRemoteDataSource:
            Get.find<PasswordUpdateRemoteDataSource>(),
      ))
      ..put(PasswordUpdateController());
  }
}
