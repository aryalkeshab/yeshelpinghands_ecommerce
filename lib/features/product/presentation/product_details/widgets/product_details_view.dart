import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/utils/constants.dart';
import 'package:yeshelpinghand/features/cart/data/model/request/cart_request_params.dart';
import 'package:yeshelpinghand/features/cart/data/model/response/cart_details.dart';
import 'package:yeshelpinghand/features/cart/presentation/controller/cart_controller.dart';
import 'package:yeshelpinghand/features/dashboard/controllers/dashboard_controller.dart';
import 'package:yeshelpinghand/features/product/presentation/controller/product_details_controller.dart';
import 'package:yeshelpinghand/features/product_compare/presentation/controller/compare_products_controller.dart';
import 'package:yeshelpinghand/features/reviews/presentation/screens/widgets/review_form_builder.dart';
import 'package:yeshelpinghand/features/shared/layouts/auth_widget_wrapper.dart';
import 'package:yeshelpinghand/features/shared/layouts/product_card.dart';
import 'package:yeshelpinghand/features/wishlist/presentation/controller/wishlist_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/resources/colors.dart';
import '../../../../../core/presentation/resources/ui_assets.dart';
import '../../../../../core/presentation/routes/app_pages.dart';
import '../../../../../core/presentation/widgets/cached_network_image_builder.dart';
import '../../../../../core/presentation/widgets/image_slider/image_slider.dart';
import '../../../../../core/utils/number_parser.dart';
import '../../../../../core/utils/string_capitalize.dart';
import '../../../../cart/presentation/screen/cart_screen.dart';
import '../../../../cart/presentation/screen/empty_cart_screen.dart';
import '../../../../product_compare/data/model/compare_product_local_params.dart';
import '../../../../reviews/presentation/screens/widgets/product_reviews_ratings.dart';
import '../../../data/model/response/product_details.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductDetails productDetails;
  final String cartCount = "0";

  ProductDetailsView({
    required this.productDetails,
  });

// This ctr and function are for image zoom
  final _transformationController = TransformationController();

  // void Function(TapDragDownDetails)? _doubleTapDetails;

  // void _handleDoubleTapDown(void Function(TapDragDownDetails)? details) {
  //   _doubleTapDetails = details;
  // }

  // void _handleDoubleTap() {
  //   if (_transformationController.value != Matrix4.identity()) {
  //     _transformationController.value = Matrix4.identity();
  //   } else {
  //     final position = _doubleTapDetails?.position;
  //     // For a 3x zoom
  //     if (position != null) {
  //       _transformationController.value = Matrix4.identity()
  //         ..translate(-position.dx * 2, -position.dy * 2)
  //         ..scale(3.0);
  //     }
  //   }
  // }

// End of Image Zoom
// diaglog box for image zoom
  _displayDialog(String imageUrl, BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
          children: [
            PinchZoom(
              child: CustomCachedNetworkImage(imageUrl,
                  isCompleteUrl: false, fit: BoxFit.contain),
              // resetDuration: const Duration(milliseconds: 100),
              maxScale: 2.5,
              onZoomStart: () {
                print('Start zooming');
              },
              onZoomEnd: () {
                print('Stop zooming');
              },
            ),
            Positioned(
              top: 50,
              right: 20,
              child: FloatingActionButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  )),
            )
          ],
        );
        var boxsized = MediaQuery.of(context).size;
        return SafeArea(
          child: Container(
            width: boxsized.width,
            height: boxsized.height,
            padding: const EdgeInsets.all(20),
            // color: backgroundDark,
            //Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 300),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: FloatingActionButton(
                      onPressed: () {
                        // _transformationController.hasListeners == false
                        //     ? Navigator.of(context).pop()
                        //     : _handleDoubleTap();

                        Navigator.of(context).pop();
                        _transformationController.value = Matrix4.identity();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return SafeArea(
        child: Container(
          padding: EdgeInsets.only(
              left: config.appEdgePadding(),
              right: config.appEdgePadding(),
              bottom: config.appVerticalPadding(6)),
          child: CustomScrollView(
            // controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 0,
                  expandedHeight: config.appHeight(38),
                  pinned: true,
                  floating: false,
                  snap: false,
                  leadingWidth: 36,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: CircleAvatar(
                      backgroundColor: backgroundLight,
                      maxRadius: 10,

                      //Theme.of(context).primaryColorLight.withOpacity(0.7),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: backgroundDark,
                          size: 16,
                          // color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: CircleAvatar(
                        backgroundColor: scaffoldBackgroundColor,
                        child: GetBuilder<CartController>(
                          builder: ((controller) {
                            final result = controller.cartDetailResponse;
                            final CartResponse? cartResponse = result.data;
                            final cartDetail = cartResponse?.cartDetail;
                            return AuthWidgetBuilder(
                                builder: ((context, isAuthenticated) {
                              return !isAuthenticated
                                  ? IconButton(
                                      // focusColor: kTeal400,
                                      icon: const Icon(CupertinoIcons.cart,
                                          size: 16),
                                      color: Colors.black,
                                      onPressed: () {
                                        Get.until((route) =>
                                            route.settings.name ==
                                            Routes.dashboard);
                                        Get.find<DashboardController>()
                                            .changeTabIndex(2);
                                      })
                                  : cartDetail?.itemsCount == 0
                                      ? IconButton(
                                          // focusColor: kTeal400,
                                          icon: const Icon(CupertinoIcons.cart,
                                              size: 16),
                                          color: Colors.black,
                                          onPressed: () {
                                            Get.until((route) =>
                                                route.settings.name ==
                                                Routes.dashboard);
                                            Get.find<DashboardController>()
                                                .changeTabIndex(2);
                                          })
                                      : Stack(children: [
                                          IconButton(
                                              // focusColor: kTeal400,
                                              icon: const Icon(
                                                  CupertinoIcons.cart,
                                                  size: 16),
                                              color: Colors.black,
                                              onPressed: () {
                                                Get.until((route) =>
                                                    route.settings.name ==
                                                    Routes.dashboard);
                                                Get.find<DashboardController>()
                                                    .changeTabIndex(2);
                                              }),
                                          Positioned(
                                            // left: 28,
                                            // top: 5,
                                            right: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              constraints: const BoxConstraints(
                                                minWidth: 15,
                                                minHeight: 15,
                                              ),
                                              child: Text(
                                                '${cartDetail?.itemsCount}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        ]);
                            }));
                          }),
                        ),
                      ),
                    ),
                    AuthWidgetBuilder(builder: (context, isAuthenticated) {
                      return IconButton(
                        onPressed: isAuthenticated
                            ? () {
                                if (productDetails.isWishlist == false) {
                                  Get.find<WishListController>()
                                      .addProductToWishList(
                                          context,
                                          int.tryParse(
                                                  "${productDetails.entityId}") ??
                                              -1,
                                          sku: '${productDetails.sku}');
                                } else {
                                  Get.find<ProductDetailsController>()
                                      .onTapFav(context, productDetails);
                                }
                              }
                            : () {
                                Get.toNamed(Routes.login, arguments: true);
                              },

                        // onPressed: () {
                        //   isAuthenticated
                        //       ?

                        //       Get.find<WishListController>()
                        //           .addProductToWishList(
                        //               context,
                        //               int.tryParse(
                        //                       "${productDetails.entityId}") ??
                        //                   -1,
                        //               sku: '${productDetails.sku}')
                        //       : Get.toNamed(Routes.login, arguments: true);

                        // },
                        icon: CircleAvatar(
                            backgroundColor: scaffoldBackgroundColor,
                            child: productDetails.isWishlist == true
                                ? const Icon(CupertinoIcons.heart_solid,
                                    color: Colors.red, size: 16.0)
                                : Icon(CupertinoIcons.heart,
                                    color: theme.primaryColor, size: 16.0)),
                      );
                    }),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: ImageSlider(
                        dotBgColor: Colors.transparent,

                        // animationDuration: const Duration(milliseconds: 700),
                        autoplay: false,
                        showIndicator: false,
                        images: List.generate(1, (i) {
                          return InkWell(
                              onTap: () => _displayDialog(
                                  "${productDetails.image?.image}", context),
                              child: CustomCachedNetworkImage(
                                  isCompleteUrl: false,
                                  "${productDetails.image?.image}"));
                        })),
                  )),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        config.verticalSpaceSmall(),
                        Text(
                          // StringUtils.capitalizeSentence(
                          //     "${productDetails.name}"),

                          "${productDetails.name?.capitalize}",
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.headline6
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        config.verticalSpaceMedium(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "AVAILABILITY: ",
                                    style: theme.textTheme.bodyText2),
                                TextSpan(
                                    text: "${productDetails.availability}",
                                    style: theme.textTheme.bodyText2
                                        ?.copyWith(color: theme.primaryColor)),
                              ]),
                            ),
                            // RichText(
                            //   text: TextSpan(children: [
                            //     TextSpan(
                            //         text: "SKU: ",
                            //         style: theme.textTheme.bodyText2),
                            //     TextSpan(
                            //         text: "${productDetails.sku}",
                            //         style: theme.textTheme.bodyText2
                            //             ?.copyWith(color: theme.primaryColor)),
                            //   ]),
                            // ),
                          ],
                        ),
                        config.verticalSpaceMedium(),
                        Visibility(
                          visible:
                              productDetails.saleableQty! > 0 ? true : false,
                          child: Column(
                            children: [
                              Text(
                                "${productDetails.saleableQty} Qty left in stock",
                                style: theme.textTheme.bodyText2
                                    ?.copyWith(color: theme.primaryColor),
                              ),
                              config.verticalSpaceMedium(),
                            ],
                          ),
                        ),
                        Text(
                          "$currency ${NumberParser.twoDecimalDigit(productDetails.price)}",
                          style: theme.textTheme.headline6
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        config.verticalSpaceMedium(),
                        Row(
                          children: [
                            Icon(Icons.star, color: Color(0xffffc516)),
                            config.horizontalSpaceSmall(),
                            Text(
                                "${productDetails.numericNormalizedAvgRating / 5}"),
                          ],
                        ),
                        config.verticalSpaceSmall(),
                        const Divider(),
                        config.verticalSpaceSmall(),
                        ReviewsAndRatings(reviews: productDetails.reviews),
                        config.verticalSpaceSmall(),
                        const Divider(),
                        config.verticalSpaceSmall(),
                        AuthWidgetWrapper(
                            child: ReviewFormBuilder(
                          productId: '${productDetails.entityId}',
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

// widget for product details on card
  Widget customCardRound(ThemeData theme, List<String>? prodInfo) {
    var str = prodInfo as List<String>;
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Card(
          elevation: null,
          color: cardbodycolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: str.map((strone) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          width: 10,
                          height: 10,
                        ),
                        const Text(
                          "\u2022",
                          // style: ,
                        ), //bullet text
                        const SizedBox(
                          width: 10,
                        ), //space between bullet and text
                        Expanded(
                          child: Text(
                            strone,
                            style: theme.textTheme.bodyText1,
                          ), //text
                        )
                      ]);
                }).toList(),
              )),
        ));
  }
}

class SelectableRatingBar extends StatelessWidget {
  final String title;
  final void Function(double value) onRatingSelection;

  const SelectableRatingBar({
    Key? key,
    required this.title,
    required this.onRatingSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return SizedBox(
        width: config.appWidth(50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            config.horizontalSpaceLarge(),
            RatingsBuilder(
              itemSize: 18,
              onRatingSelection: onRatingSelection,
            ),
          ],
        ),
      );
    });
  }
}

class ProductDetailsSectionHeading extends StatelessWidget {
  final String title;

  const ProductDetailsSectionHeading({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: grey500),
    );
  }
}
