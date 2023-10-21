import 'package:yeshelpinghand/core/data/data_source/remote/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../data/data_source/remote/api_client.dart';
import '../data/data_source/remote/api_constants.dart';
import '../data/data_source/remote/network_info.dart';

class CoreBindings extends Bindings {
  @override
  void dependencies() {
    const baseUrl = APIPathHelper.baseUrl;
    Get
      ..put(const FlutterSecureStorage(), permanent: true)
      ..put(Dio(), permanent: true)
      ..put(InternetConnectionChecker(), permanent: true)
      ..put<NetworkInfo>(NetworkInfoImpl(
          dataConnectionChecker: Get.find<InternetConnectionChecker>()))
      ..put(AuthInterceptor(Get.find<Dio>(), Get.find<FlutterSecureStorage>()))
      ..put(
          ApiClient(
              baseUrl: baseUrl,
              dio: Get.find<Dio>(),
              interceptor: Get.find<AuthInterceptor>()),
          permanent: true);
  }
}
