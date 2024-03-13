import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/brands/data/model/response/brands_model.dart';
import 'package:yeshelpinghand/features/brands/data/source/remote/brands_remote_data_source.dart';
import 'package:yeshelpinghand/features/brands/domain/repository/brands_repository.dart';

class BrandsRepositoryImpl extends BrandsRepository {
  late BrandsRemoteDataSource brandsRemoteDataSource;
  late NetworkInfo networkInfo;

  BrandsRepositoryImpl({required this.brandsRemoteDataSource, required this.networkInfo});

  @override
  Future<ApiResponse> getBrandsList() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await brandsRemoteDataSource.getBrandsList();

        final brandsList = result.map<Brand>((e) => Brand.fromJson(e)).toList();

        return ApiResponse(data: brandsList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
