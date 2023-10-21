import 'package:yeshelpinghand/core/data/data_source/local/hive_service.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/product_compare/data/repository/compare_product_repository_impl.dart';
import 'package:yeshelpinghand/features/product_compare/data/source/local/compare_product_local_data_source.dart';
import 'package:yeshelpinghand/features/product_compare/data/source/remote/compare_product_remote_data_source.dart';
import 'package:yeshelpinghand/features/product_compare/domain/repository/compare_product_repository.dart';
import 'package:yeshelpinghand/features/product_compare/presentation/controller/compare_products_controller.dart';
import 'package:get/get.dart';

class CompareProductBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<CompareProductRemoteDataSource>(
          CompareProductRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put(HiveService())
      ..put<CompareProductLocalDataSource>(CompareProductLocalDataSourceImpl(
          hiveService: Get.find<HiveService>()))
      ..put<CompareProductRepository>(CompareProductRepositoryImpl(
          compareProductLocalDataSource:
              Get.find<CompareProductLocalDataSource>(),
          networkInfo: Get.find<NetworkInfo>(),
          compareProductRemoteDataSource:
              Get.find<CompareProductRemoteDataSource>()))
      ..put(CompareProductsController());
  }
}
