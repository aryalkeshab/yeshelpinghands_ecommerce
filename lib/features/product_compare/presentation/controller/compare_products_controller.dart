import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/widgets/loading_dialog.dart';
import 'package:yeshelpinghand/core/presentation/widgets/snackbar.dart';
import 'package:yeshelpinghand/core/presentation/widgets/toast.dart';
import 'package:yeshelpinghand/features/product_compare/data/model/compare_product_local_params.dart';
import 'package:yeshelpinghand/features/product_compare/data/model/response/compare_product.dart';
import 'package:yeshelpinghand/features/product_compare/domain/repository/compare_product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CompareProductsEntity {
  bool hasData;
  List<String> ids = [];
  List<String> names = [];
  List<String> images = [];
  List<String> price = [];
  List<String> sku = [];
  List<String> availability = [];

  List<CompareProductAttributeModel> attributes = [];

  CompareProductsEntity({required this.hasData});
}

class CompareProductAttributeModel {
  String attributeName = "";
  List<dynamic> attributeValue = [];
}

class CompareProductsController extends GetxController {
  List<CompareProductAttributeModel> _compareProducts = [];

  set compareProducts(List<CompareProductAttributeModel> value) {
    _compareProducts = value;
    update();
  }

  List<CompareProductAttributeModel> get compareProducts => _compareProducts;

  ApiResponse _productCompareResponse = ApiResponse();

  set productCompareResponse(ApiResponse response) {
    _productCompareResponse = response;
    update();
  }

  ApiResponse get productCompareResponse => _productCompareResponse;

  fetchCompareProducts() async {
    final result =
        await Get.find<CompareProductRepository>().getCompareProductList();

    if (result.hasData) {
      final List<CompareProduct> productList = result.data;
      final compareProductsEntity = CompareProductsEntity(hasData: false);
      if (productList.isNotEmpty) {
        compareProductsEntity.hasData = true;
        var attributes = <Attribute?>[];
        var productAttributes = <CompareProductAttributeModel>[];

        if (productList.isNotEmpty && productList[0].attributes != null) {
          final compareProduct = productList[0];

          compareProductsEntity.ids.add("${productList[0].entityId}");
          compareProductsEntity.names.add("${productList[0].name}");
          compareProductsEntity.price.add("${productList[0].price}");
          compareProductsEntity.images
              .add("${productList[0].productImages?.image}");
          compareProductsEntity.sku.add("${productList[0].sku}");
          compareProductsEntity.availability
              .add("${productList[0].availability}");

          for (var attribute in compareProduct.attributes!) {
            final compareProductAttributeModel = CompareProductAttributeModel();
            compareProductAttributeModel.attributeName =
                "${attribute?.attributeCode}";

            compareProductAttributeModel.attributeValue
                .add("${attribute?.attributeValues}");

            compareProductsEntity.attributes.add(compareProductAttributeModel);
          }
        }

        if (productList.length > 1 && productList[1].attributes != null) {
          for (var i = 0; i < compareProductsEntity.attributes.length; i++) {
            compareProductsEntity.attributes[i].attributeValue.add("-");
          }

          final compareProductSecond = productList[1];
          compareProductsEntity.ids.add("${compareProductSecond.entityId}");
          compareProductsEntity.price.add("${compareProductSecond.price}");
          compareProductsEntity.names.add("${compareProductSecond.name}");
          compareProductsEntity.images
              .add("${compareProductSecond.productImages?.smallImage}");
          compareProductsEntity.sku.add("${compareProductSecond.sku}");
          compareProductsEntity.availability
              .add("${compareProductSecond.availability}");

          for (var i = 0; i < compareProductSecond.attributes!.length; i++) {
            var hasAttributeBeenFound = false;
            for (var j = 0; j < compareProductsEntity.attributes.length; j++) {
              if (compareProductSecond.attributes![i]?.attributeCode ==
                  compareProductsEntity.attributes[j].attributeName) {
                compareProductsEntity.attributes[j].attributeValue.removeLast();
                compareProductsEntity.attributes[j].attributeValue.add(
                    "${compareProductSecond.attributes?[i]?.attributeValues}");
                hasAttributeBeenFound = true;
                break;
              }
            }
            if (!hasAttributeBeenFound) {
              final compareProductAttributeModelForSecondProduct =
                  CompareProductAttributeModel();
              compareProductAttributeModelForSecondProduct.attributeName =
                  "${compareProductSecond.attributes![i]?.attributeCode}";

              compareProductAttributeModelForSecondProduct.attributeValue
                  .addAll([
                "-",
                "${compareProductSecond.attributes![i]?.attributeValues}"
              ]);
              compareProductsEntity.attributes
                  .add(compareProductAttributeModelForSecondProduct);
            }
          }
        }
      } else {
        compareProductsEntity.hasData = false;
      }

      productCompareResponse = ApiResponse(data: compareProductsEntity);
    } else if (result.hasError) {
      productCompareResponse = ApiResponse(error: result.error);
    }
  }

  deleteCompareProduct(BuildContext context, String id) async {
    showLoadingDialog(context);
    final result =
        await Get.find<CompareProductRepository>().deleteCompareProduct(id);
    if (result.hasData) {
      showToast(result.data);
      fetchCompareProducts();
    } else if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
    hideLoadingDialog(context);
  }

  addToCompareProductList(BuildContext context,
      CompareProductLocalParams compareProductLocalParams) async {
    showLoadingDialog(context);
    final result = await Get.find<CompareProductRepository>()
        .addToCompareProduct(compareProductLocalParams);
    if (result.hasData) {
      showToast(result.data);
      fetchCompareProducts();
    } else if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
    hideLoadingDialog(context);
  }
}
