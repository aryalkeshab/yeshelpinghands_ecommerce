import 'package:get/get.dart';

import '../../../../core/data/data_source/remote/api_result.dart';
import '../../../product/data/model/request/filter_query_params.dart';
import '../../domain/repository/products_repository.dart';

class TopDealsController extends GetxController {
  @override
  onInit() {
    super.onInit();
    fetchTopDealsProducts();
  }

  //hot deals
  ApiResponse _topDealsProductApiResponse = ApiResponse();

  set topDealsProductApiResponse(ApiResponse response) {
    _topDealsProductApiResponse = response;
    update();
  }

  ApiResponse get topDealsProductApiResponse => _topDealsProductApiResponse;

  fetchTopDealsProducts() async {
    topDealsProductApiResponse = await Get.find<ProductsRepository>()
        .fetchTopRatedProducts(FilterQueryParams(topDeals: true));
  }
}
