import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/cart/presentation/controller/cart_controller.dart';
import 'package:yeshelpinghand/features/categories/presentation/controller/category_controller.dart';
import 'package:yeshelpinghand/features/home/data/models/response/products_model.dart';
import 'package:yeshelpinghand/features/home/domain/repository/image_slider_repository.dart';
import 'package:yeshelpinghand/features/home/domain/repository/products_repository.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/best_seller_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/featured_category_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/home_banner_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/image_slider_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/top_deals_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/top_rated_controller.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yeshelpinghand/features/wishlist/presentation/controller/wishlist_controller.dart';
import '../../../brands/presentation/controller/brands_controller.dart';
import '../../../product/presentation/controller/product_listing_controller.dart';
import '../../../profile/presentation/controller/profile_controller.dart';

class HomeController extends GetxController {
  late ImageSliderRepository imageSliderRepository;
  RefreshController refreshController = RefreshController();
  late FilterQueryParams filterQueryParams;

  var selectedValue = '';

  @override
  void onInit() {
    refreshController = RefreshController();
    filterQueryParams = FilterQueryParams();

    super.onInit();
  }

  ApiResponse _allProductApiResponse = ApiResponse();

  set allProductApiResponse(ApiResponse response) {
    _allProductApiResponse = response;
    update();
  }

  ApiResponse get allProductApiResponse => _allProductApiResponse;

  List<ProductModel> productList = [];

  homeProductsList(FilterQueryParams filterQueryParams) async {
    allProductApiResponse = await Get.find<ProductsRepository>().getAllProducts(filterQueryParams);

    if (allProductApiResponse.hasData) {
      allowScroll = allProductApiResponse.data.isNextPageAvailable;
      refreshController.loadComplete();

      productList.addAll(allProductApiResponse.data.items);
    } else if (allProductApiResponse.hasError) {
      refreshController.loadFailed();
    } else {
      refreshController.loadNoData();
    }
  }

  int currentPage = 1;
  bool allowScroll = false;

  homeProductLazyList() {
    filterQueryParams.currentPage = ++currentPage;
    homeProductsList(filterQueryParams);
  }

  pullToRefresh() async {
    await Get.find<ImageSliderController>().fetchImageSlider();
    await Get.find<FeaturedCategoryController>().fetchFeaturedCategoryBanners();
    await Get.find<TopRatedController>().fetchTopRatedProducts();
    await Get.find<HomeBannerController>().getBothBanner();
    await Get.find<BestSellerController>().fetchBestSellerProducts();
    await Get.find<TopDealsController>().fetchTopDealsProducts();
    await Get.find<BrandsController>().fetchBrandsList();
    await Get.find<CartController>().getCartDetails();
    await Get.put(ProfileController()).getUserInfoResponse();
    await Get.find<CategoryController>().fetchCategoryList();
    await Get.find<WishListController>().getWishList();

    refreshController.refreshCompleted();
  }

  refreshAllScreen() async {
    await Get.find<ImageSliderController>().fetchImageSlider();
    await Get.find<FeaturedCategoryController>().fetchFeaturedCategoryBanners();
    await Get.find<TopRatedController>().fetchTopRatedProducts();
    await Get.find<HomeBannerController>().getBothBanner();
    await Get.find<BestSellerController>().fetchBestSellerProducts();
    await Get.find<TopDealsController>().fetchTopDealsProducts();
    await Get.find<BrandsController>().fetchBrandsList();
    await Get.find<CartController>().getCartDetails();
    await Get.find<CategoryController>().fetchCategoryList();
    await Get.find<ProductListingController>().fetchProductList(filterQueryParams);
    await Get.find<ProfileController>().getUserInfoResponse();
    await Get.find<WishListController>().getWishList();

    refreshController.refreshCompleted();
  }
}
