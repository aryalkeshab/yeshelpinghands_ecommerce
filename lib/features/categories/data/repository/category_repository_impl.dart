import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/categories/data/models/response/category.dart';
import 'package:yeshelpinghand/features/categories/data/source/remote/category_remote_data_source.dart';

import '../../domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl(
      {required this.networkInfo, required this.categoryRemoteDataSource});

  @override
  Future<ApiResponse> getAllCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await categoryRemoteDataSource.getAllCategories();

        final categoryList = result["children_data"]
            .map<Category>((e) => Category.fromJson(e))
            .toList();
        return ApiResponse(data: categoryList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
