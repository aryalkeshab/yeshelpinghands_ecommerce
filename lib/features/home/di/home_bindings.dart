import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_client.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/brands/presentation/controller/brands_controller.dart';
import 'package:yeshelpinghand/features/home/data/repository/banner_repository_impl.dart';
import 'package:yeshelpinghand/features/home/data/repository/featured_category_repository_impl.dart';
import 'package:yeshelpinghand/features/home/data/repository/home_banner_repository_impl.dart';
import 'package:yeshelpinghand/features/product/data/repository/products_repository_impl.dart';
import 'package:yeshelpinghand/features/brands/data/source/remote/brands_remote_data_source.dart';
import 'package:yeshelpinghand/features/home/data/source/remote/featured_category_remote_data_source.dart';
import 'package:yeshelpinghand/features/home/data/source/remote/home_banner_remote_data_source.dart';
import 'package:yeshelpinghand/features/product/data/data_source/remote/products_remote_data_source.dart';
import 'package:yeshelpinghand/features/home/data/source/remote/image_slider_remote_data_source.dart';
import 'package:yeshelpinghand/features/brands/domain/repository/brands_repository.dart';
import 'package:yeshelpinghand/features/home/domain/repository/featured_category_repository.dart';
import 'package:yeshelpinghand/features/home/domain/repository/home_banner_repository.dart';
import 'package:yeshelpinghand/features/home/domain/repository/image_slider_repository.dart';
import 'package:yeshelpinghand/features/home/domain/repository/products_repository.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/best_seller_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/featured_category_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/home_banner_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/home_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/image_slider_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/top_deals_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/top_rated_controller.dart';

import '../../brands/data/repository/brands_repository_impl.dart';
import '../data/repository/image_slider_repository_impl.dart';
import '../domain/repository/banner_repository.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<BannerRemoteDataSource>(
          BannerRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<ImageSliderRepository>(ImageSliderRepositoryImpl(
          imageSliderRemoteDataSource: Get.find<BannerRemoteDataSource>(),
          networkInfo: Get.find<NetworkInfo>()))
      ..put<HomeBannerRemoteDataSource>(
          HomeBannerRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<HomeBannerRepository>(HomeBannerRepositoryImpl(
          homeBannerRemoteDataSource: Get.find<HomeBannerRemoteDataSource>(),
          networkInfo: Get.find<NetworkInfo>()))
      ..put<ProductRemoteDataSource>(
          ProductsRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<ProductsRepository>(ProductsRepositoryImpl(
          networkInfo: Get.find<NetworkInfo>(),
          productsRemoteDataSource: Get.find<ProductRemoteDataSource>()))
      ..put<BrandsRemoteDataSource>(
          BrandsRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<BrandsRepository>(BrandsRepositoryImpl(
          networkInfo: Get.find<NetworkInfo>(),
          brandsRemoteDataSource: Get.find<BrandsRemoteDataSource>()))
      ..put<FeaturedCategoryRemoteDataSource>(
          FeaturedCategoryRemoteDataSourceImpl(
              apiClient: Get.find<ApiClient>()))
      ..put<FeaturedCategoryRepository>(FeaturedCategoryRepositoryImpl(
          featuredCategoryRemoteDataSource:
              Get.find<FeaturedCategoryRemoteDataSource>(),
          networkInfo: Get.find<NetworkInfo>()))
      ..put(HomeController())
      ..put<BannerRemoteDataSource>(
          BannerRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()))
      ..put<BannerRepository>(BannerRepositoryImpl(
          bannerRemoteDataSource: Get.find<BannerRemoteDataSource>(),
          networkInfo: Get.find<NetworkInfo>()))
      ..put(ImageSliderController())
      ..put(HomeBannerController())
      ..put(TopDealsController())
      ..put(TopRatedController())
      ..put(BestSellerController())
      ..put(FeaturedCategoryController())
      ..put(BrandsController());
  }
}
