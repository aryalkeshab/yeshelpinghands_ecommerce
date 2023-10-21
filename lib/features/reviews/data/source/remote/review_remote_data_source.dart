import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

import '../../model/review_params.dart';

abstract class ReviewRemoteDataSource {
  dynamic addProductReview(String id, ReviewParams reviewParams);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final ApiClient apiClient;

  ReviewRemoteDataSourceImpl({required this.apiClient});

  @override
  addProductReview(String id, ReviewParams reviewParams) {
    return apiClient.authPost(APIPathHelper.reviewAPIs(APIPath.reviews, id: id),
        data: reviewParams.toJson());
  }
}
