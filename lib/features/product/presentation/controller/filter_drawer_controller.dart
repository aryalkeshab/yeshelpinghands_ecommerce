import 'package:get/get.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import 'package:yeshelpinghand/features/product/presentation/controller/product_listing_controller.dart';

import '../../../../core/data/data_source/remote/api_result.dart';
import '../../../home/domain/repository/products_repository.dart';

class FilterDrawerController extends GetxController {
  @override
  onInit() {
    super.onInit();
  }

  // ApiResponse _filterModelResponse = ApiResponse();

  // set filterModelResponse(ApiResponse response) {
  //   _filterModelResponse = response;
  //   update();
  // }

  // ApiResponse get filterModelResponse => _filterModelResponse;

  // fetchFilterModel(FilterQueryParams params) async {
  //   setBaseFilterParams(params);
  //   filterModelResponse = await Get.find<ProductsRepository>()
  //       .getFilterModel("${params.categoryId}");
  // }

  // FilterQueryParams baseQueryParams = FilterQueryParams();

  // setBaseFilterParams(FilterQueryParams params) {
  //   baseQueryParams = params;
  //   filterQueryParams = params;
  // }

  FilterQueryParams filterQueryParams = FilterQueryParams();

  updateCategoryId(int categoryId) {
    filterQueryParams.categoryId = categoryId;
  }

  // clearFilter() {
  //   filterQueryParams
  //     ..categoryId = baseQueryParams.categoryId
  //     ..outOfStock = null
  //     ..inStock = null
  //     ..minPrice = null
  //     ..maxPrice = null;
  // }
}
