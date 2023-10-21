import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_info.dart';
import 'package:yeshelpinghand/features/product_compare/data/model/response/compare_product.dart';
import 'package:yeshelpinghand/features/product_compare/domain/repository/compare_product_repository.dart';
import '../../../../core/data/data_source/remote/network_exception.dart';
import '../model/compare_product_local_params.dart';
import '../source/local/compare_product_local_data_source.dart';
import '../source/remote/compare_product_remote_data_source.dart';

//
// class CompareProductRepositoryImpl extends CompareProductRepository {
//   final CompareProductRemoteDataSource compareProductRemoteDataSource;
//   final CompareProductLocalDataSource compareProductLocalDataSource;
//   final NetworkInfo networkInfo;
//
//   CompareProductRepositoryImpl(
//       {required this.networkInfo,
//       required this.compareProductLocalDataSource,
//       required this.compareProductRemoteDataSource});
//
//   @override
//   Future<ApiResponse> getCompareProductList() async {
//     if (await networkInfo.isConnected) {
//       try {
//         final result =
//             await compareProductRemoteDataSource.getCompareProductList();
//         if (result.isEmpty) return ApiResponse(data: <CompareProduct>[]);
//
//         final productList = result
//             .map<CompareProduct>((e) => CompareProduct.fromJson(e))
//             .toList();
//
//         return ApiResponse(data: productList);
//       } catch (e) {
//         return ApiResponse(error: NetworkException.getException(e));
//       }
//     } else {
//       return ApiResponse(error: NetworkException.noInternetConnection());
//     }
//   }
//
//   @override
//   Future<ApiResponse> deleteCompareProduct(String id) async {
//     if (await networkInfo.isConnected) {
//       try {
//         final result =
//             await compareProductRemoteDataSource.deleteCompareProduct(id);
//
//         return ApiResponse(data: result[0]["message"]);
//       } catch (e) {
//         return ApiResponse(error: NetworkException.getException(e));
//       }
//     } else {
//       return ApiResponse(error: NetworkException.noInternetConnection());
//     }
//   }
//
//   @override
//   Future<ApiResponse> addToCompareProduct(String id) async {
//     if (await networkInfo.isConnected) {
//       try {
//         final result =
//             await compareProductRemoteDataSource.addToCompareProduct(id);
//
//         return ApiResponse(data: result[0]["message"]);
//       } catch (e) {
//         if (e is DioError && e.type == DioErrorType.response) {
//           return ApiResponse(
//               error: NetworkException.defaultError(
//                   value: e.response?.data[0]["error"]));
//         }
//         return ApiResponse(error: NetworkException.getException(e));
//       }
//     } else {
//       return ApiResponse(error: NetworkException.noInternetConnection());
//     }
//   }
//
//   @override
//   Future<ApiResponse> getProductsFromCompareList() {
//     // TODO: implement getProductsFromCompareList
//     throw UnimplementedError();
//   }
// }
class CompareProductRepositoryImpl extends CompareProductRepository {
  final CompareProductRemoteDataSource compareProductRemoteDataSource;
  final CompareProductLocalDataSource compareProductLocalDataSource;
  final NetworkInfo networkInfo;

  CompareProductRepositoryImpl(
      {required this.networkInfo,
      required this.compareProductLocalDataSource,
      required this.compareProductRemoteDataSource});

  @override
  Future<ApiResponse> getCompareProductList() async {
    if (await networkInfo.isConnected) {
      try {
        final List<CompareProductLocalParams> paramsList =
            await compareProductLocalDataSource.fetchProductIds();

        var productIds = <String>[];
        for (var element in paramsList) {
          productIds.add(element.id);
        }
        if (productIds.isEmpty) return ApiResponse(data: <CompareProduct>[]);
        final result = await compareProductRemoteDataSource
            .getCompareProductList(productIds);

        final productList = result
            .map<CompareProduct>((e) => CompareProduct.fromJson(e))
            .toList();

        return ApiResponse(data: productList);
      } catch (e) {
        return ApiResponse(error: NetworkException.getException(e));
      }
    } else {
      return ApiResponse(error: NetworkException.noInternetConnection());
    }
  }

  @override
  Future<ApiResponse> deleteCompareProduct(String id) async {
    try {
      await compareProductLocalDataSource
          .deleteProductId(int.tryParse(id) ?? 0);
      return ApiResponse(
          data: "Successfully Removed from Product Compare List");
    } catch (e) {
      return ApiResponse(
          error: NetworkException.defaultError(value: e.toString()));
    }
  }

  checkForValidEntry(String entryProductCategoryId,
      List<CompareProductLocalParams> localParamsList) {
    var isValid = false;
    for (var element in localParamsList) {
      if (element.categoryId == entryProductCategoryId) {
        isValid = true;
        break;
      }
    }
    return isValid;
  }

  @override
  Future<ApiResponse> addToCompareProduct(
      CompareProductLocalParams compareProductLocalParams) async {
    try {
      final List<CompareProductLocalParams> localParamsList =
          await compareProductLocalDataSource.fetchProductIds();

      if (localParamsList.isEmpty ||
          checkForValidEntry(
              compareProductLocalParams.categoryId, localParamsList)) {
        await compareProductLocalDataSource
            .addProductId(compareProductLocalParams);
        return ApiResponse(data: "Successfully Added to Product Compare List");
      }
      return ApiResponse(
          error: NetworkException.defaultError(
              value: "Can't add product of different category"));
    } catch (e) {
      return ApiResponse(
          error: NetworkException.defaultError(value: e.toString()));
    }
  }

  @override
  Future<ApiResponse> getProductsFromCompareList() {
    // TODO: implement getProductsFromCompareList
    throw UnimplementedError();
  }
}
