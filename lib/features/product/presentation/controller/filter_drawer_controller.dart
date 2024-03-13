import 'package:get/get.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';

class FilterDrawerController extends GetxController {
  @override
  onInit() {
    super.onInit();
  }

  FilterQueryParams filterQueryParams = FilterQueryParams();

  updateCategoryId(int categoryId) {
    filterQueryParams.categoryId = categoryId;
  }
}
