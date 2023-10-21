import 'package:get/get.dart';

import '../../../../core/data/data_source/remote/api_result.dart';
import '../../../product/data/model/request/filter_query_params.dart';
import '../../domain/repository/products_repository.dart';

class BestSellerController extends GetxController {
  @override
  onInit() {
    super.onInit();
    fetchBestSellerProducts();
  }

  //hot deals
  ApiResponse _bestSellerProductApiResponse = ApiResponse();

  set bestSellerProductApiResponse(ApiResponse response) {
    _bestSellerProductApiResponse = response;
    update();
  }

  ApiResponse get bestSellerProductApiResponse => _bestSellerProductApiResponse;

  fetchBestSellerProducts() async {
    bestSellerProductApiResponse = await Get.find<ProductsRepository>()
        .fetchTopRatedProducts(FilterQueryParams(bestSeller: true));
  }
}
