import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/categories/data/repository/category_repository_impl.dart';
import 'package:yeshelpinghand/features/categories/data/source/remote/category_remote_data_source.dart';
import 'package:yeshelpinghand/features/categories/domain/repository/category_repository.dart';
import 'package:get/get.dart';

import '../../../core/data/data_source/remote/api_client.dart';

class CategoryBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<CategoryRemoteDataSource>(
          CategoryRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<CategoryRepository>(CategoryRepositoryImpl(
          networkInfo: Get.find<NetworkInfo>(),
          categoryRemoteDataSource: Get.find<CategoryRemoteDataSource>()));
  }
}
