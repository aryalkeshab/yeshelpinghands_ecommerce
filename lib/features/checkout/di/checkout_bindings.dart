import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/checkout/data/repository/checkout_repository_impl.dart';
import 'package:yeshelpinghand/features/checkout/data/source/remote/checkout_remote_data_source.dart';
import 'package:yeshelpinghand/features/checkout/domain/repository/checkout_repository.dart';
import 'package:yeshelpinghand/features/checkout/presentation/controller/checkout_controller.dart';
import 'package:yeshelpinghand/features/checkout/presentation/controller/payment_methods_controller.dart';
import 'package:yeshelpinghand/features/checkout/presentation/controller/shipping_method_controller.dart';
import 'package:get/get.dart';

class CheckoutBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<CheckoutRemoteDataSource>(
          CheckoutRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<CheckoutRepository>(CheckoutRepositoryImpl(
          networkInfo: Get.find<NetworkInfo>(),
          checkoutRemoteDataSource: Get.find<CheckoutRemoteDataSource>()))
      ..put(ShippingMethodController())
      ..put(PaymentMethodsController())
      ..put(CheckoutController());
  }
}
