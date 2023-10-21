import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/auth/data/data_source/remote/password_reset_remote_data_source.dart';
import 'package:yeshelpinghand/features/auth/data/repository/password_reset_repository_impl.dart';
import 'package:yeshelpinghand/features/auth/domain/repository/password_reset_repository.dart';
import 'package:yeshelpinghand/features/auth/presentation/controller/password_reset_controller.dart';
import 'package:get/get.dart';

class PasswordResetBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<PasswordResetRemoteDataSource>(
          PasswordResetRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<PasswordResetRepository>(PasswordResetRepositoryImpl(
        networkInfo: Get.find<NetworkInfo>(),
        passwordResetRemoteDataSource:
            Get.find<PasswordResetRemoteDataSource>(),
      ))
      ..put(PasswordResetController());
  }
}
