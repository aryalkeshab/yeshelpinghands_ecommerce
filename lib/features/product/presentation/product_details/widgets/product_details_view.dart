import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/utils/constants.dart';
import 'package:yeshelpinghand/features/cart/data/model/response/cart_details.dart';
import 'package:yeshelpinghand/features/cart/presentation/controller/cart_controller.dart';
import 'package:yeshelpinghand/features/dashboard/controllers/dashboard_controller.dart';
import 'package:yeshelpinghand/features/product/presentation/controller/product_details_controller.dart';
import 'package:yeshelpinghand/features/shared/layouts/auth_widget_wrapper.dart';
import 'package:yeshelpinghand/features/wishlist/presentation/controller/wishlist_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/presentation/resources/colors.dart';
import '../../../../../core/presentation/routes/app_pages.dart';
import '../../../../../core/presentation/widgets/cached_network_image_builder.dart';
import '../../../../../core/presentation/widgets/image_slider/image_slider.dart';
import '../../../../../core/utils/number_parser.dart';
import '../../../../reviews/presentation/screens/widgets/product_reviews_ratings.dart';
import '../../../data/model/response/product_details.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductDetails productDetails;
  final String cartCount = "0";

  ProductDetailsView({
    required this.productDetails,
  });

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
              child: CustomCachedNetworkImage(imageUrl, isCompleteUrl: false, fit: BoxFit.contain),
              maxScale: 2.5,
              onZoomStart: () {},
              onZoomEnd: () {},
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: config.appHorizontalPaddingSmall()),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0,
                expandedHeight: config.appHeight(38),
                pinned: true,
                leadingWidth: 40,
                leading: Padding(
                  padding: EdgeInsets.symmetric(horizontal: config.appHorizontalPaddingSmall()),
                  child: CircleAvatar(
                    backgroundColor: backgroundLight,
                    maxRadius: 30,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: backgroundDark,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                actions: <Widget>[
                  GetBuilder<CartController>(
                    builder: ((controller) {
                      final result = controller.cartDetailResponse;
                      final CartResponse? cartResponse = result.data;
                      final cartDetail = cartResponse?.carts;
                      return AuthWidgetBuilder(builder: ((context, isAuthenticated) {
                        return !isAuthenticated
                            ? IconButton(
                                icon: const Icon(CupertinoIcons.cart, size: 25),
                                color: theme.primaryColor,
                                onPressed: () {
                                  Get.until((route) => route.settings.name == Routes.dashboard);
                                  Get.find<DashboardController>().changeTabIndex(2);
                                })
                            : cartDetail?.length == 0
                                ? IconButton(
                                    icon: const Icon(CupertinoIcons.cart, size: 25),
                                    color: theme.primaryColor,
                                    onPressed: () {
                                      Get.until((route) => route.settings.name == Routes.dashboard);
                                      Get.find<DashboardController>().changeTabIndex(2);
                                    })
                                : Stack(children: [
                                    IconButton(
                                        icon: const Icon(CupertinoIcons.cart, size: 25),
                                        color: theme.primaryColor,
                                        onPressed: () {
                                          Get.until(
                                              (route) => route.settings.name == Routes.dashboard);
                                          Get.find<DashboardController>().changeTabIndex(2);
                                        }),
                                    Positioned(
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 15,
                                          minHeight: 15,
                                        ),
                                        child: Text(
                                          '${cartDetail?.length}',
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
                  AuthWidgetBuilder(builder: (context, isAuthenticated) {
                    return IconButton(
                      onPressed: isAuthenticated
                          ? () {
                              if (productDetails.isWishlist == false) {
                                Get.find<WishListController>().addProductToWishList(
                                    context, productDetails.slug.toString(),
                                    sku: '${productDetails.slug}');
                              } else {
                                Get.find<ProductDetailsController>()
                                    .onTapFav(context, productDetails);
                              }
                            }
                          : () {
                              Get.until((route) => route.settings.name == Routes.dashboard);
                              Get.find<DashboardController>().changeTabIndex(3);
                            },
                      icon: CircleAvatar(
                          backgroundColor: scaffoldBackgroundColor,
                          child: productDetails.isWishlist == true
                              ? const Icon(CupertinoIcons.heart_solid,
                                  color: Colors.red, size: 25.0)
                              : Icon(CupertinoIcons.heart, color: theme.primaryColor, size: 25.0)),
                    );
                  }),
                ],
                flexibleSpace: Container(
                  color: Colors.white,
                  child: ImageSlider(
                    dotBgColor: Colors.transparent,
                    autoplay: false,
                    showIndicator: false,
                    images: List.generate(productDetails.additionalImages!.length, (i) {
                      return CustomCachedNetworkImage(
                          isDetailPage: true,
                          fit: BoxFit.contain,
                          isCompleteUrl: false,
                          "${productDetails.additionalImages?[i].image}");
                    }),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: config.appHorizontalPaddingSmall(),
                          right: config.appHorizontalPaddingSmall(),
                          bottom: config.appVerticalPadding(6)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          config.verticalSpaceSmall(),
                          Text(
                            "${productDetails.name?.capitalize}",
                            maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.headline6?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          config.verticalSpaceSmall(),
                          Text(
                            "${productDetails.description}",
                            textAlign: TextAlign.justify,
                            style: theme.textTheme.headline6?.copyWith(fontWeight: FontWeight.w200),
                          ),
                          config.verticalSpaceMedium(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "AVAILABILITY: ", style: theme.textTheme.bodyText2),
                                  TextSpan(
                                      text:
                                          "${productDetails.inventory == 0 ? "OUT OF STOCK" : "IN STOCK"}",
                                      style: theme.textTheme.bodyText2
                                          ?.copyWith(color: theme.primaryColor)),
                                ]),
                              ),
                            ],
                          ),
                          config.verticalSpaceMedium(),
                          Visibility(
                            visible: productDetails.inventory! > 10 ? true : false,
                            child: Column(
                              children: [
                                Text(
                                  "${productDetails.inventory} Qty left in stock",
                                  style: theme.textTheme.bodyText2
                                      ?.copyWith(color: theme.primaryColor),
                                ),
                                config.verticalSpaceMedium(),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  productDetails.offerPrice! > 0 &&
                                          productDetails.offerPrice! < productDetails.price!
                                      ? Row(
                                          children: [
                                            Text(
                                              "$currency ${NumberParser.twoDecimalDigit(productDetails.offerPrice.toString())}",
                                              style: theme.textTheme.bodyText1?.copyWith(
                                                  color: primaryColor2,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                            config.horizontalSpaceSmall(),
                                          ],
                                        )
                                      : Container(),
                                  Text(
                                    "$currency ${NumberParser.twoDecimalDigit(productDetails.price.toString())}",
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyText1?.copyWith(
                                        color: productDetails.offerPrice! > 0 &&
                                                productDetails.offerPrice! < productDetails.price!
                                            ? Colors.red
                                            : primaryColor,
                                        fontSize: productDetails.offerPrice! > 0 &&
                                                productDetails.offerPrice! < productDetails.price!
                                            ? 12
                                            : 14,
                                        fontWeight: FontWeight.w600,
                                        decorationColor: Colors.red,
                                        decoration: productDetails.offerPrice! > 0 &&
                                                productDetails.offerPrice! < productDetails.price!
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Color(0xffffc516)),
                                  config.horizontalSpaceSmall(),
                                  Text("${productDetails.avgRating ?? 0 / 5}"),
                                ],
                              ),
                            ],
                          ),
                          config.verticalSpaceSmall(),
                          const Divider(),
                          config.verticalSpaceSmall(),
                          ReviewsAndRatings(reviews: productDetails.reviews),
                          config.verticalSpaceSmall(),
                          const Divider(),
                          config.verticalSpaceSmall(),
                        ],
                      ),
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
                  return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    const SizedBox(
                      width: 10,
                      height: 10,
                    ),
                    const Text(
                      "\u2022",
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
