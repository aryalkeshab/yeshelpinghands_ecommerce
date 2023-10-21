import 'package:get/get.dart';

import '../../../../core/data/data_source/remote/api_result.dart';
import '../../../product/data/model/request/filter_query_params.dart';
import '../../domain/repository/products_repository.dart';

class TopRatedController extends GetxController {
  @override
  onInit() {
    super.onInit();
    fetchTopRatedProducts();
  }


  ApiResponse _topRatedProductApiResponse = ApiResponse();

  set topRatedProductApiResponse(ApiResponse response) {
    _topRatedProductApiResponse = response;
    update();
  }

  ApiResponse get topRatedProductApiResponse => _topRatedProductApiResponse;

  fetchTopRatedProducts() async {
    topRatedProductApiResponse = await Get.find<ProductsRepository>()
        .fetchTopRatedProducts(FilterQueryParams(topRated: true));
  }
}
