import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/auth/data/data_source/local/auth_local_data_source.dart';
import 'package:yeshelpinghand/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:yeshelpinghand/features/auth/data/repository/auth_repository_impl.dart';
import 'package:yeshelpinghand/features/auth/domain/repository/auth_repository.dart';
import 'package:yeshelpinghand/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<AuthLocalDataSource>(AuthLocalDataSourceImpl(Get.find<FlutterSecureStorage>()),
          permanent: true)
      ..put<AuthRemoteDataSource>(AuthRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()),
          permanent: true)
      ..put<AuthRepository>(
          AuthRepositoryImpl(
              networkInfo: Get.find<NetworkInfo>(),
              authLocalDataSource: Get.find<AuthLocalDataSource>(),
              authRemoteDataSource: Get.find<AuthRemoteDataSource>()),
          permanent: true)
      ..put(AuthController(), permanent: true);
  }
}
