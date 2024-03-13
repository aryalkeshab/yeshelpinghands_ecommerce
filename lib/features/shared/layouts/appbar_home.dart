import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import 'package:yeshelpinghand/features/wishlist/presentation/controller/wishlist_controller.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool showBottomWidget;
  final Widget? bottomWidget;

  const AppBarHome({
    Key? key,
    required this.title,
    this.showBottomWidget = false,
    this.bottomWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return AppBar(
        leadingWidth: 30,
        centerTitle: true,
        title: title,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: config.appHorizontalPaddingLarge()),
            child: GetBuilder<WishListController>(builder: (wishlistController) {
              return wishlistController.wishList.isEmpty
                  ? IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        Get.toNamed(Routes.wishList);
                      },
                    )
                  : Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
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
        bottom: HomeAppBarBottomSection(onSearchBarPressed: () {
          Get.toNamed(Routes.search);
        }),
      );
    });
  }

  @override
  Size get preferredSize => const Size(double.infinity, 150);
}

class HomeAppBarBottomSection extends StatelessWidget implements PreferredSizeWidget {
  final Color? fillColor;
  final VoidCallback onSearchBarPressed;

  const HomeAppBarBottomSection({
    Key? key,
    this.fillColor,
    required this.onSearchBarPressed,
  }) : super(key: key);

  navigateToProductListing(int categoryId) {
    Get.toNamed(
      Routes.productListingScreen,
      arguments: FilterQueryParams(categoryId: categoryId, pageSize: 40),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: config.appEdgePadding()),
            child: SearchBarContainer(onPressed: onSearchBarPressed),
          ),
        ],
      );
    });
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _AppBarBottomMenu extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const _AppBarBottomMenu({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return InkWell(
        onTap: onPressed,
        child: Container(
          child: Text(
            "${title.capitalizeFirst}",
            style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.black),
          ),
          padding: EdgeInsets.symmetric(
            vertical: config.appVerticalPadding(0.4),
            horizontal: config.appHorizontalPadding(2),
          ),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        ),
      );
    });
  }
}

class SearchBarContainer extends StatelessWidget implements PreferredSizeWidget {
  final Color? fillColor;
  final VoidCallback onPressed;

  const SearchBarContainer({
    Key? key,
    this.fillColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: BaseWidget(builder: (context, config, theme) {
        return Container(
          padding: EdgeInsets.only(
              left: config.appHorizontalPaddingMedium(), right: config.appHorizontalPaddingSmall()),
          height: config.appHeight(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 1,
              color: Colors.black38.withOpacity(0.2),
            ),
            color: fillColor ?? const Color(0xfff2f2f2),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: const Color(0xffABA8A8),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Search your products',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: const Color(0xffABA8A8)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
