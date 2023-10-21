import 'package:yeshelpinghand/features/home/data/source/remote/image_slider_remote_data_source.dart';
import 'package:yeshelpinghand/features/home/data/models/request/image_slider_response.dart';
import 'package:yeshelpinghand/features/home/domain/repository/image_slider_repository.dart';
import '../../../../core/data/data_source/remote/api_result.dart';
import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../../core/data/data_source/remote/network_info.dart';

class ImageSliderRepositoryImpl extends ImageSliderRepository {
  late BannerRemoteDataSource imageSliderRemoteDataSource;
  late NetworkInfo networkInfo;

  ImageSliderRepositoryImpl({
    required this.imageSliderRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<ApiResponse> getImageSlider() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await imageSliderRemoteDataSource.getSingleBanner();
        final mappedImageSlider = response[0]['image']
            .map((e) => BannerResponse.fromJson(e))
            .toList();
        return ApiResponse(data: mappedImageSlider);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
