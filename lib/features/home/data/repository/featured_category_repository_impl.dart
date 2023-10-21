import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/home/data/models/response/featured_category_model.dart';
import 'package:yeshelpinghand/features/home/data/source/remote/featured_category_remote_data_source.dart';
import 'package:yeshelpinghand/features/home/domain/repository/featured_category_repository.dart';

class FeaturedCategoryRepositoryImpl extends FeaturedCategoryRepository {
  late FeaturedCategoryRemoteDataSource featuredCategoryRemoteDataSource;
  late NetworkInfo networkInfo;

  FeaturedCategoryRepositoryImpl(
      {required this.featuredCategoryRemoteDataSource,
      required this.networkInfo});

  @override
  Future<ApiResponse> getFeaturedCategory() async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await featuredCategoryRemoteDataSource.getFeaturedCategory();
        final featuredCategoryList = response[0]['image']
            .map<FeaturedCategoryModel>(
                (e) => FeaturedCategoryModel.fromJson(e))
            .toList();
        return ApiResponse(data: featuredCategoryList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
