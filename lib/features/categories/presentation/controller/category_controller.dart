import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/categories/domain/repository/category_repository.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    refreshController = RefreshController();

    fetchCategoryList();
    super.onInit();
  }

  ApiResponse _categoryApiResponse = ApiResponse();

  set categoryApiResponse(ApiResponse response) {
    _categoryApiResponse = response;
    update();
  }

  ApiResponse get categoryApiResponse => _categoryApiResponse;

  fetchCategoryList() async {
    categoryApiResponse = await Get.find<CategoryRepository>().getAllCategories();
    refreshController.refreshCompleted();
  }
}
