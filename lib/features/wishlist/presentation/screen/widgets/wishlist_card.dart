import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/core/utils/constants.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/cart_request_params.dart';
import 'package:yeshelpinghand/features/cart/presentation/controller/cart_controller.dart';
import 'package:yeshelpinghand/features/shared/layouts/confirm_dialog_view.dart';
import 'package:yeshelpinghand/features/wishlist/data/model/wishlist.dart';
import 'package:yeshelpinghand/features/wishlist/presentation/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/presentation/resources/colors.dart';
import '../../../../../core/presentation/routes/app_pages.dart';
import '../../../../../core/presentation/widgets/base_widget.dart';
import '../../../../../core/presentation/widgets/cached_network_image_builder.dart';
import '../../../../../core/utils/number_parser.dart';
import '../../../../shared/layouts/remove_button.dart';

class WishlistCard extends StatelessWidget {
  final WishListProduct wishListProduct;

  const WishlistCard({
    Key? key,
    required this.wishListProduct,
  }) : super(key: key);

  void navigateToProductDetails() {
    Get.toNamed(Routes.productDetails, arguments: wishListProduct.slug);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishListController>(builder: (controller) {
      return BaseWidget(builder: (context, config, themeData) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: navigateToProductDetails,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: CustomCachedNetworkImage(
                        isCompleteUrl: false,
                        "${wishListProduct.image}",
                        fit: BoxFit.fill,
                      ),
                      height: 80,
                      width: config.appWidth(20),
                    ),
                  ),
                ),
                config.horizontalSpaceMedium(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                          wishListProduct.slug.toString(),
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
                          borderColor:
                              wishListProduct.isProductInStock! ? primaryColor : lightGreen,
                          title: wishListProduct.isProductInStock! ? "Add to Cart" : "Out of Stock",
                          onPressed: wishListProduct.isProductInStock!
                              ? () {
                                  Get.find<CartController>().addToCart(
                                      context, CartParams(slug: wishListProduct.slug, qty: 1));
                                }
                              : () {},
                        ),
                      ],
                    ),
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
