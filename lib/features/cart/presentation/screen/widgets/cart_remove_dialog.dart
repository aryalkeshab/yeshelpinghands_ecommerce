import 'package:yeshelpinghand/features/cart/data/model/response/cart_details.dart';
import 'package:yeshelpinghand/features/cart/presentation/controller/cart_controller.dart';
import 'package:yeshelpinghand/features/cart/presentation/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/layouts/confirm_dialog_view.dart';

class CartItemRemoveDialog extends StatelessWidget {
  final BuildContext context;
  final CartItem cartItem;

  const CartItemRemoveDialog(this.context, {Key? key, required this.cartItem})
      : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return ConfirmDialogView(
      primaryText: "Are you sure you want to remove this item from cart?",
      onCancelButtonPressed: Get.back,
      onApproveButtonPressed: () {
        Get.find<CartController>().removeProductFromCart(
            context, int.parse(cartItem.itemId.toString()));
        // Navigator.pop(context);
      },
    );
  }
}

class CartClearDialog extends StatelessWidget {
  const CartClearDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmDialogView(
      primaryText: "Are you sure you want to clear your cart?",
      onCancelButtonPressed: Get.back,
      onApproveButtonPressed: () {
        Get.find<CartController>().removeAllProductFromCart(context);
        // Get.back();
      },
    );
  }
}
