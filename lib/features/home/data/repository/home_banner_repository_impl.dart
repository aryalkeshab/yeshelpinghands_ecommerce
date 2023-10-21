import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/home/data/source/remote/home_banner_remote_data_source.dart';
import 'package:yeshelpinghand/features/home/data/models/request/home_banner_response.dart';
import 'package:yeshelpinghand/features/home/domain/repository/home_banner_repository.dart';

class HomeBannerRepositoryImpl extends HomeBannerRepository {
  late HomeBannerRemoteDataSource homeBannerRemoteDataSource;
  late NetworkInfo networkInfo;

  HomeBannerRepositoryImpl(
      {required this.homeBannerRemoteDataSource, required this.networkInfo});

  @override
  Future<ApiResponse> getBannerList(String identifier) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await homeBannerRemoteDataSource.getBannerList(identifier);
        final mappedHomeBanner = response[0]['image']
            .map((e) => HomeBannerResponse.fromJson(e))
            .toList();
        return ApiResponse(data: mappedHomeBanner);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
