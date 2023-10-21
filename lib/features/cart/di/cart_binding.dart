import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/cart/data/data_source/remote/cart_remote_data_source.dart';
import 'package:yeshelpinghand/features/cart/data/repository/cart_repository_impl.dart';
import 'package:yeshelpinghand/features/cart/domain/repository/cart_repository.dart';
import 'package:yeshelpinghand/features/cart/presentation/controller/cart_controller.dart';
import 'package:get/get.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<CartRemoteDataSource>(
          CartRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()),
          permanent: true)
      ..put<CartRepository>(
          CartRepositoryImpl(
              networkInfo: Get.find<NetworkInfo>(),
              cartRemoteDataSource: Get.find<CartRemoteDataSource>()),
          permanent: true)
      ..put(CartController(), permanent: true);
  }
}
