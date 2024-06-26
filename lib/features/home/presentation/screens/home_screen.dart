import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/resources/colors.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/circular_cached_network_image_builder.dart';
import 'package:yeshelpinghand/core/presentation/widgets/image_slider/image_slider.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/core/utils/size_config.dart';
import 'package:yeshelpinghand/features/brands/presentation/brand_listing_view.dart';
import 'package:yeshelpinghand/features/dashboard/controllers/dashboard_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/home_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/image_slider_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/screens/home_banner_view.dart';
import 'package:yeshelpinghand/features/home/presentation/screens/product_section/brands_section.dart';
import 'package:yeshelpinghand/features/home/presentation/screens/product_section/top_deals_section.dart';
import 'package:yeshelpinghand/features/home/presentation/screens/product_section/featured_category_section.dart';
import 'package:yeshelpinghand/features/home/presentation/screens/product_section/top_rated_products_section.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
import 'package:yeshelpinghand/features/wishlist/data/model/wishlist.dart';
import 'package:yeshelpinghand/features/wishlist/presentation/controller/wishlist_controller.dart';

import '../../../../core/data/data_source/remote/api_constants.dart';
import '../../../../core/presentation/resources/ui_assets.dart';
import '../../../../core/presentation/widgets/buttons.dart';
import '../../../profile/presentation/controller/profile_controller.dart';
import '../../../shared/layouts/appbar_home.dart';
import '../../../shared/layouts/auth_widget_wrapper.dart';
import 'product_section/best_seller_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig(context);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 198, 184, 184),
        backgroundColor: Colors.transparent,
        elevation: 2,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                CupertinoIcons.person_alt_circle,
                color: primaryColor,
                size: 35,
              ),
              onPressed: () {
                Get.put(DashboardController()).changeTabIndex(3);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: config.appHorizontalPaddingLarge()),
            child:
                GetBuilder<WishListController>(builder: (wishlistController) {
              return wishlistController.wishList.isEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.wishList);
                      },
                    )
                  : Stack(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Theme.of(context).primaryColor,
                            size: 25,
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.wishList);
                          },
                        ),
                        Positioned(
                          top: 5,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 15,
                              minHeight: 15,
                            ),
                            child: Text(
                              '${wishlistController.wishList.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    );
            }),
          ),
        ],
        centerTitle: true,
        title: Column(
          children: [
            InkWell(
              child: Image.asset(
                UIAssets.app_Icon,
                width: 200,
              ),
              onTap: () {},
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // Adjust the height as needed
          child: HomeAppBarBottomSection(onSearchBarPressed: () {
            Get.toNamed(Routes.search);
          }),
        ),
      ),
      body: GetBuilder<HomeController>(builder: (controller) {
        return BaseWidget(builder: (context, config, theme) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: config.appEdgePadding(),
              vertical: config.appHorizontalPaddingSmall(),
            ),
            child: SmartRefresher(
              controller: controller.refreshController,
              enablePullUp: false,
              enablePullDown: true,
              header: const WaterDropHeader(),
              onRefresh: () => controller.pullToRefresh(),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  HomeCarousal(),
                  // config.verticalSpaceLarge(),
                  // const FeaturedCategorySection(),
                  config.verticalSpaceSmall(),
                  const TopRatedProductsSection(),
                  config.verticalSpaceSmall(),
                  const MultiBannerView(),
                  config.verticalSpaceSmall(),
                  const BestSellerSection(),
                  config.verticalSpaceSmall(),
                  const TopDealProductsSection(),
                  // config.verticalSpaceMedium(),
                  // const SingleBannerView(),
                  // config.verticalSpaceLarge(),
                  // const HomeBrandSection(),
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}

class HomeCarousal extends StatelessWidget {
  HomeCarousal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _config = SizeConfig(context);
    return GetBuilder<ImageSliderController>(builder: (controller) {
      final result = controller.imageSliderResponse;
      if (result.hasData) {
        final sliderResponseList = result.data;

        if (sliderResponseList.isNotEmpty) {
          return SizedBox(
              height: _config.appHeight(16),
              child: ImageSlider(
                  dotSize: 0,
                  dotBgColor: Colors.transparent,
                  images: sliderResponseList
                      .map((slider) => CircularCachedNetworkImageBuilder(
                            imageUrl:
                                "${APIPathHelper.baseUrlImage + slider.image}",
                            borderRadius: 8,
                            isBorderEnabled: false,
                          ))
                      .toList()));
        } else {
          return SizedBox.shrink();
        }
      } else if (result.hasError) {
        return ErrorView(
          title: NetworkException.getErrorMessage(result.error),
        );
      } else {
        return ShimmerWidget.rounded(height: _config.appHeight(18));
      }
    });
  }
}

class _DrawerMenuItem extends StatelessWidget {
  final String title;

  final VoidCallback onPressed;

  /// Icon for home drawer menu item
  ///
  /// [icon] can be String or IconData
  final dynamic icon;

  const _DrawerMenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  })  : assert(icon is String || icon is IconData),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context) {
                if (icon is String) {
                  return Image.asset(
                    icon,
                    width: 25,
                  );
                } else {
                  return Icon(icon);
                }
              },
            ),
            config.horizontalSpaceMedium(),
            Text(title),
          ],
        ),
      );
    });
  }
}
