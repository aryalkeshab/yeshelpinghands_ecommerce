import '../../../../core/data/data_source/remote/api_result.dart';
import '../../data/model/review_params.dart';

abstract class ReviewRepository {
  Future<ApiResponse> addProductReview(String id, ReviewParams reviewParams);
}
