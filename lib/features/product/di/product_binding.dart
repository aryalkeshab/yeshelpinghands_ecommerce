import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import '../../home/domain/repository/products_repository.dart';
import '../data/data_source/remote/products_remote_data_source.dart';
import '../data/repository/products_repository_impl.dart';

class ProductBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<ProductRemoteDataSource>(ProductsRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()),
          permanent: true)
      ..put<ProductsRepository>(
          ProductsRepositoryImpl(
              networkInfo: Get.find<NetworkInfo>(),
              productsRemoteDataSource: Get.find<ProductRemoteDataSource>()),
          permanent: true);
  }
}
