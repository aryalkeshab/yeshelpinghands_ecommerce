import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/paystack/data/repository/paystack_repository_impl.dart';
import 'package:yeshelpinghand/features/paystack/data/source/paystack_data_source.dart';
import 'package:yeshelpinghand/features/paystack/presentation/controller/paystack_controller.dart';

import '../domain/paystack_repository.dart';

class PaystackBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<PaystackDataSource>(PaystackDataSourceImpl(dio: Dio()))
      ..put<PaystackRepository>(PaystackRepositoryImpl(
          secureStorage: Get.find<FlutterSecureStorage>(),
          paystackDataSource: Get.find<PaystackDataSource>(),
          networkInfo: Get.find<NetworkInfo>()))
      ..put(PaystackController());
  }
}
