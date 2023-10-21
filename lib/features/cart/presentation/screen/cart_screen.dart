import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/core/presentation/widgets/cached_network_image_builder.dart';
import 'package:yeshelpinghand/core/utils/constants.dart';
import 'package:yeshelpinghand/core/utils/number_parser.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/update_cart_params.dart';
import 'package:yeshelpinghand/features/cart/presentation/controller/cart_controller.dart';
import 'package:yeshelpinghand/features/cart/presentation/screen/widgets/cart_loading_view.dart';
import 'package:yeshelpinghand/features/cart/presentation/screen/widgets/cart_remove_dialog.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
import 'package:yeshelpinghand/features/shared/layouts/remove_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/presentation/resources/colors.dart';
import '../../../checkout/data/model/request/confirm_order_params.dart';
import '../../../shared/layouts/loading_pulse.dart';
import '../../data/model/response/cart_details.dart';
import 'empty_cart_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    Get.find<CartController>().getCartDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: GetBuilder<CartController>(
          init: CartController(),
          builder: (controller) {
            return BaseWidget(builder: (context, config, theme) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: config.appHeight(20),
                  left: config.appEdgePadding(),
                  right: config.appEdgePadding(),
                ),
                child: GetBuilder<CartController>(builder: (controller) {
                  final result = controller.cartDetailResponse;
                  if (result.hasData) {
                    final CartResponse cartResponse = result.data;
                    final cartDetail = cartResponse.cartDetail;
                    if (cartDetail?.itemsCount == 0) {
                      return const EmptyCartScreen();
                    }
                    return CartItemListView(
                      cartItems: cartDetail?.items ?? [],
                    );
                  } else if (result.hasError) {
                    return Center(
                      child: ErrorView(
                        title: NetworkException.getErrorMessage(result.error),
                      ),
                    );
                  } else {
                    return const CartLoadingView();
                  }
                }),
              );
            });
          }),
      bottomSheet: GetBuilder<CartController>(builder: (controller) {
        final result = controller.cartDetailResponse;
        if (result.hasData) {
          final CartResponse cartResponse = result.data;
          final cartDetail = cartResponse.cartDetail;
          return cartDetail?.itemsCount != 0
              ? _CartSummaryView(cartDetail: cartDetail)
              : const SizedBox.shrink();
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}

class CartItemListView extends StatelessWidget {
  const CartItemListView({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Builder(builder: (context) {
        return ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                CartItemCard(
                  cartItem: cartItems[index],
                ),
                config.verticalSpaceMedium(),
              ],
            );
          },
        );
      });
    });
  }
}

class _CartSummaryView extends StatelessWidget {
  _CartSummaryView({
    Key? key,
    required this.cartDetail,
  }) : super(key: key);
  final CartDetail? cartDetail;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: config.appVerticalPaddingSmall(),
              horizontal: config.appEdgePadding()),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _CartSummaryItem(
                title: 'Sub total',
                value:
                    "${NumberParser.twoDecimalDigit('${cartDetail?.subtotal}')}",
              ),
              config.verticalSpaceSmall(),
              const _CartSummaryItem(
                title: 'Shipping Fee',
                value: "0.00",
              ),
              config.verticalSpaceSmall(),
              _CartSummaryItem(
                  isPrimary: true,
                  title: 'Total',
                  value:
                      "${NumberParser.twoDecimalDigit('${cartDetail?.grandTotal}')}"),
              PrimaryButton(
                label: "Checkout",
                onPressed: () {
                  final confirmOrderParams =
                      ConfirmOrderParams(cartDetail: cartDetail);
                  Get.toNamed(Routes.shipping, arguments: confirmOrderParams);
                },
              ),
            ],
          ),
        ),
        height: 140,
      );
    });
  }
}

class _CartSummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isPrimary;

  const _CartSummaryItem({
    Key? key,
    required this.title,
    required this.value,
    this.isPrimary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, config, theme) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: isPrimary
                  ? theme.textTheme.bodyText1
                      ?.copyWith(fontWeight: FontWeight.w600)
                  : theme.textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.caption?.color),
            ),
            Text(
              "$currency $value",
              style: isPrimary
                  ? theme.textTheme.bodyText1
                      ?.copyWith(fontWeight: FontWeight.w600)
                  : theme.textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.caption?.color),
            ),
          ],
        );
      },
    );
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.productDetails, arguments: cartItem.sku);
      },
      child: BaseWidget(builder: (context, config, theme) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            // border: Border.all(),
          ),
          padding: EdgeInsets.symmetric(
              vertical: config.appHeight(1),
              horizontal: config.appEdgePadding()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                child: CustomCachedNetworkImage(
                  cartItem.image?.image,
                  isCompleteUrl: false,
                ),
                width: config.appWidth(20),
              ),
              config.horizontalSpaceMedium(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${cartItem.name}",
                      style: theme.textTheme.bodyText2,
                    ),
                    config.verticalSpaceSmall(),
                    Text(
                      "$currency ${NumberParser.twoDecimalDigit(cartItem.price.toString())}",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    config.verticalSpaceSmall(),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RemoveButton(onRemove: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return CartItemRemoveDialog(ctx,
                                  cartItem: cartItem);
                            },
                          );
                        }),
                        QuantityChangerButtonsView(
                          cartItem: cartItem,
                        ),
                      ],
                    ),
                    config.verticalSpaceMedium(),
                    Obx(() {
                      if (Get.find<CartController>()
                              .showCartLoadingIndicator
                              .value &&
                          Get.find<CartController>().updateCartItemId ==
                              int.tryParse("${cartItem.itemId}"))
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            LoadingPulse(),
                          ],
                        );
                      else
                        return const SizedBox.shrink();
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class QuantityChangerButtonsView extends StatelessWidget {
  final CartItem cartItem;

  const QuantityChangerButtonsView({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QuantityChangerButton(
            icon: Icons.remove,
            onPressed: () {
              if ((cartItem.qty ?? 0) > 1) {
                Get.find<CartController>().updateCart(
                    context,
                    UpdateCartParams(
                        cartItemId: NumberParser.intFromString(cartItem.itemId),
                        sku: "${cartItem.sku}",
                        quantity:
                            cartItem.qty != null ? cartItem.qty! - 1 : 1));
              }
            },
          ),
          config.horizontalSpaceMedium(),
          GetBuilder<CartController>(builder: (context) {
            return Text('${cartItem.qty}');
          }),
          config.horizontalSpaceMedium(),
          _QuantityChangerButton(
            icon: Icons.add,
            onPressed: () {
              Get.find<CartController>().updateCart(
                  context,
                  UpdateCartParams(
                      cartItemId: NumberParser.intFromString(cartItem.itemId),
                      sku: "${cartItem.sku}",
                      quantity: cartItem.qty != null ? cartItem.qty! + 1 : 1));
            },
          ),
        ],
      );
    });
  }
}

class _QuantityChangerButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const _QuantityChangerButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: theme.primaryColor, width: 1.5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18,
            color: theme.primaryColor,
          ),
        ),
      );
    });
  }
}

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: GetBuilder<CartController>(builder: (controller) {
        final result = controller.cartDetailResponse;

        if (result.hasData) {
          final CartResponse cartResponse = result.data;
          return Text(
            'My Cart (${cartResponse.cartDetail?.itemsCount})',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white),
          );
        } else {
          return Text(
            'My Cart (0)',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white),
          );
        }
      }),
      actions: [
        BaseWidget(builder: (context, config, theme) {
          return Padding(
            padding: EdgeInsets.only(right: config.appEdgePadding()),
            child: GetBuilder<CartController>(
              builder: (controller) => Visibility(
                visible: controller.cartDetailResponse.hasData &&
                    controller
                            .cartDetailResponse.data?.cartDetail?.itemsCount !=
                        0,
                child: InkWell(
                  child: const Icon(
                    CupertinoIcons.delete,
                    size: 18,
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return const CartClearDialog();
                        });
                  },
                ),
              ),
            ),
          );
        })
      ],
      elevation: 1,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
