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
import 'package:yeshelpinghand/features/dashboard/controllers/dashboard_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/home_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/image_slider_controller.dart';
import 'package:yeshelpinghand/features/home/presentation/screens/home_banner_view.dart';
import 'package:yeshelpinghand/features/home/presentation/screens/product_section/top_deals_section.dart';
import 'package:yeshelpinghand/features/home/presentation/screens/product_section/top_rated_products_section.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
import '../../../../core/data/data_source/remote/api_constants.dart';
import '../../../../core/presentation/resources/ui_assets.dart';
import '../../../shared/layouts/appbar_home.dart';
import 'product_section/best_seller_section.dart';
import 'product_section/categories_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: config.appEdgePadding(),
            vertical: config.appHorizontalPaddingSmall(),
          ),
          child: Column(
            children: [
              Container(
                height: config.appHeight(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GetBuilder<HomeController>(builder: (controller) {
                        return CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          child: ClipOval(
                            child: Image.asset(
                              UIAssets.appIcon,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      }),
                    ),
                    Expanded(
                      flex: 7,
                      child: HomeAppBarBottomSection(onSearchBarPressed: () {
                        Get.toNamed(Routes.search);
                      }),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: ClipOval(
                            child: Icon(
                              CupertinoIcons.person_alt_circle,
                              color: primaryColor,
                              size: 35,
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.put(DashboardController()).changeTabIndex(3);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GetBuilder<HomeController>(builder: (controller) {
                  return BaseWidget(builder: (context, config, theme) {
                    return SmartRefresher(
                      controller: controller.refreshController,
                      enablePullUp: false,
                      enablePullDown: true,
                      header: const WaterDropHeader(),
                      onRefresh: () => controller.pullToRefresh(),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          config.verticalSpaceMedium(),
                          HomeCarousal(),
                          config.verticalSpaceSmall(),
                          const CategorySection(),
                          config.verticalSpaceSmall(),
                          const TopRatedProductsSection(),
                          config.verticalSpaceSmall(),
                          const MultiBannerView(),
                          config.verticalSpaceSmall(),
                          const BestSellerSection(),
                          config.verticalSpaceSmall(),
                          const TopDealProductsSection(),
                        ],
                      ),
                    );
                  });
                }),
              ),
            ],
          ),
        ),
      ),
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
          return Container(
              height: _config.appHeight(18),
              child: ImageSlider(
                  dotSize: 0,
                  dotBgColor: Colors.transparent,
                  images: sliderResponseList
                      .map((slider) => CircularCachedNetworkImageBuilder(
                            imageUrl: "${APIPathHelper.baseUrlImage + slider.image}",
                            borderRadius: 8,
                            isBorderEnabled: true,
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
