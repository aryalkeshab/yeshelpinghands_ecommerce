import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';

abstract class HomeBannerRepository {
  Future<ApiResponse> getBannerList(String identifier);
}
