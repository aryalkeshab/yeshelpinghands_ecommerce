import 'package:yeshelpinghand/features/auth/data/data_source/remote/social_login_data_source.dart';
import 'package:yeshelpinghand/features/auth/domain/repository/login_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../core/data/data_source/remote/api_client.dart';
import '../../../core/data/data_source/remote/network_info.dart';
import '../data/data_source/remote/login_remote_data_source.dart';
import '../data/repository/login_repository_impl.dart';
import '../presentation/controller/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<LoginRemoteDataSource>(LoginRemoteDataSourceImpl(Get.find<ApiClient>()))
      ..put<SocialLoginDataSource>(SocialLoginDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<LoginRepository>(LoginRepositoryImpl(
        loginRemoteDataSource: Get.find<LoginRemoteDataSource>(),
        networkInfo: Get.find<NetworkInfo>(),
        secureStorage: Get.find<FlutterSecureStorage>(),
      ))
      ..put(LoginController());
  }
}
