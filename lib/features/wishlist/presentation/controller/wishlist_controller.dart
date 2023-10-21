import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/widgets/loading_dialog.dart';
import 'package:yeshelpinghand/core/presentation/widgets/toast.dart';
import 'package:yeshelpinghand/features/product/presentation/controller/product_details_controller.dart';
import 'package:yeshelpinghand/features/wishlist/domain/repository/wishList_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/widgets/snackbar.dart';
import '../../data/model/wishlist.dart';

class WishListController extends GetxController {
  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    // TODO: implement onInit
    refreshController = RefreshController();

    getWishList();
    super.onInit();
  }

  ApiResponse _removeWishListResponse = ApiResponse();

  set removeWishListResponse(ApiResponse response) {
    _removeWishListResponse = response;
    update();
  }

  ApiResponse get removeWishListResponse => _removeWishListResponse;

  removeProductFromWishList(
    BuildContext context,
    int id,
  ) async {
    final result = await Get.find<WishListRepository>().removeWishList(id);
    if (result.hasData) {
      AppSnackbar.showSnackbarWithActionButton(
          snackbarIcon: Icons.remove_circle_outline_outlined,
          context: context,
          message: result.data);
      getWishList();
    } else if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
    if (removeWishListResponse.hasData) {
      showToast(addWishListResponse.data);
    }
  }

  ApiResponse _removeFromWishListResponse = ApiResponse();

  set removeFromWishListResponse(ApiResponse response) {
    _removeWishListResponse = response;
    update();
  }

  ApiResponse get removeFromWishListResponse => _removeFromWishListResponse;

  removeProductFromWishListScreen(
    BuildContext context,
    int id,
  ) async {
    final result = await Get.find<WishListRepository>().removeWishList(id);
    if (result.hasData) {
      AppSnackbar.showSuccess(context: context, message: result.data);
      getWishList();
    } else if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
    if (removeFromWishListResponse.hasData) {
      showToast(addWishListResponse.data);
    }
  }

  //clearWishList
  clearProductFromWishList(
    BuildContext context,
  ) async {
    final result = await Get.find<WishListRepository>().clearWishList();
    if (result.hasData) {
      AppSnackbar.showSuccess(context: context, message: result.data);

      getWishList();
    } else if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
    hideLoadingDialog(context);
  }

//add to Wish List
  ApiResponse _addToWishListResponse = ApiResponse();

  set addWishListResponse(ApiResponse response) {
    _addToWishListResponse = response;
    update();
  }

  ApiResponse get addWishListResponse => _addToWishListResponse;

  addProductToWishList(BuildContext context, int id,
      {required String sku}) async {
    addWishListResponse = await Get.find<WishListRepository>().postWishList(id);
    if (addWishListResponse.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(addWishListResponse.error));
    }
    if (addWishListResponse.hasData) {
      Get.find<ProductDetailsController>().fetchProductDetails(sku);
      AppSnackbar.showSnackbarWithActionButton(
          snackbarIcon: Icons.add_circle_outline_outlined,
          context: context,
          message: addWishListResponse.data);
      getWishList();
    }
  }

  //getWishList

  ApiResponse _wishListResponse = ApiResponse();

  set wishlistResponse(ApiResponse response) {
    _wishListResponse = response;
    update();
  }

  ApiResponse get wishlistResponse => _wishListResponse;
  final wishList = <WishList>[];

  getWishList() async {
    wishlistResponse =
        await Get.find<WishListRepository>().getAllWishListProducts();
    wishList.clear();
    if (wishlistResponse.hasData) {
      wishList.addAll(wishlistResponse.data);
    } else {
      wishList.clear();
    }
    refreshController.refreshCompleted();
  }
}
