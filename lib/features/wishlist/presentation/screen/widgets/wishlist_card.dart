import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/core/utils/constants.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/cart_request_params.dart';
import 'package:yeshelpinghand/features/cart/presentation/controller/cart_controller.dart';
import 'package:yeshelpinghand/features/shared/layouts/confirm_dialog_view.dart';
import 'package:yeshelpinghand/features/wishlist/presentation/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/resources/colors.dart';
import '../../../../../core/presentation/routes/app_pages.dart';
import '../../../../../core/presentation/widgets/base_widget.dart';
import '../../../../../core/presentation/widgets/cached_network_image_builder.dart';

import '../../../../../core/utils/number_parser.dart';
import '../../../../home/data/models/response/products_model.dart';
import '../../../../shared/layouts/remove_button.dart';

class WishlistCard extends StatelessWidget {
  final ProductModel wishListProduct;

  const WishlistCard({
    Key? key,
    required this.wishListProduct,
  }) : super(key: key);

  void navigateToProductDetails() {
    Get.toNamed(Routes.productDetails, arguments: wishListProduct.sku);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishListController>(builder: (controller) {
      return BaseWidget(builder: (context, config, themeData) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(config.appEdgePadding()),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: navigateToProductDetails,
                  child: SizedBox(
                    child: CustomCachedNetworkImage(
                        isCompleteUrl: false, "${wishListProduct.thumbnail}"),
                    width: 100,
                  ),
                ),
                config.horizontalSpaceMedium(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: navigateToProductDetails,
                          child: Text("${wishListProduct.name}")),
                      config.verticalSpaceSmall(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$currency ${NumberParser.twoDecimalDigit(wishListProduct.price.toString())}",
                            style: themeData.textTheme.bodyText1
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          RemoveButton(onRemove: () {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return ConfirmDialogView(
                                    primaryText:
                                        "Are you sure want to remove this item from your wishlist?",
                                    onApproveButtonPressed: () {
                                      Get.find<WishListController>()
                                          .removeProductFromWishListScreen(
                                        context,
                                        int.parse(
                                            wishListProduct.id.toString()),
                                      );
                                      Get.back();
                                    },
                                    onCancelButtonPressed: Get.back);
                              },
                            );
                          }),
                        ],
                      ),
                      PrimaryOutlinedButton(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.02,
                        borderColor: wishListProduct.isProductInStock!
                            ? primaryColor
                            : lightGreen,
                        title: wishListProduct.isProductInStock!
                            ? "Add to Cart"
                            : "Out of Stock",
                        onPressed: wishListProduct.isProductInStock!
                            ? () {
                                Get.find<CartController>().addToCart(
                                    context,
                                    CartParams(
                                        sku: wishListProduct.sku, qty: 1));
                              }
                            : () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
    });
  }
}
