import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/reviews/data/repository/review_repository_impl.dart';
import 'package:yeshelpinghand/features/reviews/data/source/remote/review_remote_data_source.dart';
import 'package:yeshelpinghand/features/reviews/domain/repository/review_repository.dart';
import 'package:get/get.dart';

import '../presentation/controllers/review_controller.dart';

class ReviewBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<ReviewRemoteDataSource>(
          ReviewRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<ReviewRepository>(ReviewRepositoryImpl(
          reviewRemoteDataSource: Get.find<ReviewRemoteDataSource>(),
          networkInfo: Get.find<NetworkInfo>()))
      ..put(ReviewController());
  }
}
