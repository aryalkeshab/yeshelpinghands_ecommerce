import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/core/data/model/paged_response.dart';

import 'package:yeshelpinghand/features/home/data/models/response/products_model.dart';
import 'package:yeshelpinghand/features/product/data/data_source/remote/products_remote_data_source.dart';
import 'package:yeshelpinghand/features/home/domain/repository/products_repository.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import 'package:yeshelpinghand/features/product/data/model/response/filter_drawer_model.dart';

import '../model/response/product_details.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductRemoteDataSource productsRemoteDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl(
      {required this.networkInfo, required this.productsRemoteDataSource});

  @override
  Future<ApiResponse> getAllProducts(
      FilterQueryParams filterQueryParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await productsRemoteDataSource.getAllProducts(filterQueryParams);

        final productsList = result['data']["data"]
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList();

        // TODO: page size manage

        return ApiResponse(
            data: PagedResponse<ProductModel>(
                items: productsList,
                perPage: result["data"]["current_page"],
                isNextPageAvailable: true,
                totalCount: result["data"]["total"]));
        // data: PagedResponse<ProductModel>(
        // items: productsList,
        // perPage: result[0]["page_size"],
        // isNextPageAvailable: result[0]["isNextPageAvailable"],
        // totalCount: result[0]["total_count"]));
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> getBestSellingProducts(
      FilterQueryParams filterQueryParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productsRemoteDataSource
            .getBestSellingProducts(filterQueryParams);

        final productsList = result['data']["data"]
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList();

        return ApiResponse(data: productsList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> fetchTopRatedProducts(
      FilterQueryParams filterQueryParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productsRemoteDataSource
            .getTopRatedProducts(filterQueryParams);

        final productsList = result['data']["data"]
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList();

        return ApiResponse(data: productsList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> getExclusiveDealsProduct(
      FilterQueryParams filterQueryParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productsRemoteDataSource
            .getExclusiveDealsProduct(filterQueryParams);

        final productsList = result['data']["data"]
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList();

        return ApiResponse(data: productsList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> getCashBackOfferProducts(
      FilterQueryParams filterQueryParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productsRemoteDataSource
            .getCashBackOfferProducts(filterQueryParams);

        final productsList = result['data']["data"]
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList();

        return ApiResponse(data: productsList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> getNewArrivalProducts(
      FilterQueryParams filterQueryParams) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productsRemoteDataSource
            .getNewArrivalProducts(filterQueryParams);

        final productsList = result['data']["data"]
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList();

        return ApiResponse(data: productsList
            // data: PagedResponse<ProductModel>(
            //       items: productsList,
            //       perPage: result[0]["page_size"],
            //       isNextPageAvailable: result[0]["product_exists"],
            //       totalCount: result[0]["total_count"])
            );
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> getProductDetails(String sku) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productsRemoteDataSource.getProductDetails(sku);

        // final productList = ProductDetails.fromJson(result["data"]);
        final productList = ProductDetails.fromJson(result["data"]);

        return ApiResponse(data: productList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> getFilterModel(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productsRemoteDataSource.getFilterModel(id);

        final filterModel = FilterDrawerModel.fromJson(result[0]);
        return ApiResponse(data: filterModel);
      } catch (e) {
        return ApiResponse(data: FilterDrawerModel.init());
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }
}
