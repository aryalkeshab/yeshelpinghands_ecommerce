import 'package:flutter/cupertino.dart';
import 'package:yeshelpinghand/features/home/data/models/response/products_model.dart';
import 'package:yeshelpinghand/features/home/domain/repository/products_repository.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../core/data/data_source/remote/api_result.dart';
import '../../../../core/presentation/widgets/loading_dialog.dart';

class ProductListingController extends GetxController {
  final FilterQueryParams filterQueryParams;

  ProductListingController(this.filterQueryParams);

  late RefreshController refreshController;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController();
    fetchProductList(filterQueryParams);
  }

  double? minPrice;
  double? maxPrice;

  late ApiResponse _productListResponse = ApiResponse();

  set productListResponse(ApiResponse response) {
    _productListResponse = response;
    update();
  }

  ApiResponse get productListResponse => _productListResponse;

  List<ProductModel> productList = [];

  fetchProductList(FilterQueryParams filterQueryParams,
      {bool filterData = true}) async {
    productListResponse =
        await Get.find<ProductsRepository>().getAllProducts(filterQueryParams);

    if (productListResponse.hasData) {
      if (filterData == true) productList.clear();
      allowPullUp = productListResponse.data.isNextPageAvailable;
      productList.addAll(productListResponse.data.items);
    } else {
      allowPullUp = false;
    }

    refreshController.refreshCompleted();
  }

  void onProductsFilter(
      BuildContext context, FilterQueryParams filterQueryParams,
      {bool filterData = true}) async {
    // showLoadingDialog(context);
    currentPage = 1;
    filterQueryParams.currentPage = currentPage;

    await fetchProductList(filterQueryParams, filterData: filterData);
    // hideLoadingDialog(context);
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  int currentPage = 1;
  bool allowPullUp = false;

  productLazyLoad(FilterQueryParams filterQueryParams) {
    filterQueryParams.currentPage = ++currentPage;
    fetchProductList(filterQueryParams, filterData: false);
  }
}
