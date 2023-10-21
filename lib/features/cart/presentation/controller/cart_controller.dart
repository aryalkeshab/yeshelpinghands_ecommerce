import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/widgets/loading_dialog.dart';
import 'package:yeshelpinghand/core/presentation/widgets/snackbar.dart';
import 'package:yeshelpinghand/core/presentation/widgets/toast.dart';

import 'package:yeshelpinghand/features/cart/data/model/request/cart_request_params.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/update_cart_params.dart';
import 'package:yeshelpinghand/features/cart/domain/repository/cart_repository.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CartController extends GetxController {
  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    refreshController = RefreshController();

    getCartDetails();
    super.onInit();
  }

  addToCart(BuildContext context, CartParams cartParams) async {
    final result = await Get.find<CartRepository>().addToCartItems(cartParams);
    if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
    if (result.hasData) {
      AppSnackbar.showSnackbarWithActionButton(
          context: context,
          snackbarIcon: Icons.add_shopping_cart_sharp,
          message: result.data);
      getCartDetails();
    }
  }

  var showCartLoadingIndicator = false.obs;
  int updateCartItemId = 0;

  updateCart(BuildContext context, UpdateCartParams updateCartParams) async {
    updateCartItemId = updateCartParams.cartItemId;
    showCartLoadingIndicator.value = true;

    final result =
        await Get.find<CartRepository>().updateCart(updateCartParams);
    showCartLoadingIndicator.value = false;

    if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
    if (result.hasData) {
      getCartDetails();
    }
  }

  void removeProductFromCart(BuildContext context, int id) async {
    final result = await Get.find<CartRepository>().removeProductFromCart(id);
    if (result.hasData) {
      AppSnackbar.showSuccess(context: context, message: result.data);
      getCartDetails();
    } else if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
    hideLoadingDialog(context);
  }

  //remove all products

  void removeAllProductFromCart(BuildContext context) async {
    final result = await Get.find<CartRepository>().removeAllProductFromCart();
    if (result.hasData) {
      AppSnackbar.showSuccess(context: context, message: result.data);

      getCartDetails();
    } else if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
    hideLoadingDialog(context);
  }

  //get cart list

  ApiResponse _cartDetailResponse = ApiResponse();

  set cartDetailResponse(ApiResponse response) {
    _cartDetailResponse = response;
    update();
  }

  ApiResponse get cartDetailResponse => _cartDetailResponse;

  getCartDetails() async {
    cartDetailResponse = await Get.find<CartRepository>().getCartDetails();
    refreshController.refreshCompleted();
  }
}
