import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/reviews/data/source/remote/review_remote_data_source.dart';

import '../../../../core/data/data_source/remote/api_result.dart';
import '../../domain/repository/review_repository.dart';
import '../model/review_params.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final NetworkInfo networkInfo;
  final ReviewRemoteDataSource reviewRemoteDataSource;

  ReviewRepositoryImpl(
      {required this.reviewRemoteDataSource, required this.networkInfo});

  @override
  Future<ApiResponse> addProductReview(
      String id, ReviewParams reviewParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await reviewRemoteDataSource.addProductReview(id, reviewParams);
        return ApiResponse(data: result[0]["message"]);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(
        error: NetworkException.noInternetConnection(),
      );
    }
  }
}
