import 'package:yeshelpinghand/core/presentation/resources/colors.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/features/cart/data/model/response/cart_details.dart';
import 'package:yeshelpinghand/features/cart/presentation/controller/cart_controller.dart';
import 'package:yeshelpinghand/features/dashboard/controllers/dashboard_controller.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import 'package:yeshelpinghand/features/product/presentation/product_listing/product_listing_screen.dart';
import '../../../../../core/presentation/widgets/base_widget.dart';
import '../../../../../core/utils/size_config.dart';

class ProductListingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(FilterQueryParams Function(FilterQueryParams)) onSortUpdate;
  final bool? isDash;

  ProductListingAppBar({required this.onSortUpdate, this.isDash = false});

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig(context);
    final themeData = Theme.of(context);
    return AppBar(
      backgroundColor: themeData.primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
          child: Padding(
              padding: EdgeInsets.only(bottom: config.appVerticalPaddingSmall()),
              child: _SortHeading(
                onSortParamSelect: (sortParam) {
                  onSortUpdate(
                    (FilterQueryParams filterQueryParams) {
                      filterQueryParams.sort = sortParam.value;
                      return filterQueryParams;
                    },
                  );
                },
                onSortOrderSelect: (order) {
                  onSortUpdate(
                    (FilterQueryParams filterQueryParams) {
                      return filterQueryParams;
                    },
                  );
                },
              )),
          preferredSize: const Size(double.maxFinite, 45)),
      actions: <Widget>[
        if (isDash == false)
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
        config.horizontalSpaceSmall(),
        Expanded(
          child: InkWell(
            onTap: () {
              Get.offAndToNamed(Routes.search);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
              child: Container(
                  height: config.appHeight(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 1,
                        color: Colors.black38.withOpacity(0.2),
                      ),
                      color: const Color(0xfff2f2f2)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      config.horizontalSpaceSmall(),
                      Icon(
                        CupertinoIcons.search,
                        size: 20,
                        color: grey500,
                      ),
                      config.horizontalSpaceSmall(),
                      Text(
                        'You are looking for...',
                        style: themeData.textTheme.bodyText2?.copyWith(color: grey500),
                        textAlign: TextAlign.left,
                      ),
                      const Spacer(),
                      config.horizontalSpaceSmall(),
                    ],
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
          child: IconButton(
            icon: Stack(
              children: [
                Icon(CupertinoIcons.cart),
                Align(
                  alignment: Alignment.topRight,
                  child: GetBuilder<CartController>(builder: (controller) {
                    final result = controller.cartDetailResponse;
                    if (result.hasData) {
                      final CartResponse cartResponse = result.data;
                      return CircleAvatar(
                        radius: 7,
                        backgroundColor: Colors.red,
                        child: Text("${cartResponse.carts?.length}",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(color: Colors.white)),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                ),
              ],
            ),
            onPressed: () {
              Get.until((route) => route.settings.name == Routes.dashboard);
              Get.find<DashboardController>().changeTabIndex(2);
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight + 50);
}

class _SortHeading extends StatefulWidget {
  final Function(SortOrder) onSortOrderSelect;
  final Function(SortParameter) onSortParamSelect;

  _SortHeading({
    Key? key,
    required this.onSortOrderSelect,
    required this.onSortParamSelect,
  }) : super(key: key);

  @override
  State<_SortHeading> createState() => _SortHeadingState();
}

class _SortHeadingState extends State<_SortHeading> {
  SortParameter sortParameter = SortParameter.values.first;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: config.appHorizontalPaddingSmall()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                UpDownSort(
                  onSortTap: widget.onSortOrderSelect,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.359,
                  child: DropdownButton<SortParameter>(
                    dropdownColor: theme.primaryColor,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    elevation: 0,
                    hint: Text("Sort"),
                    itemHeight: kMinInteractiveDimension,
                    underline: const SizedBox.shrink(),
                    borderRadius: BorderRadius.circular(5),
                    alignment: Alignment.centerRight,
                    value: sortParameter,
                    isDense: true,
                    items: SortParameter.values.map((SortParameter sortParam) {
                      return DropdownMenuItem<SortParameter>(
                          value: sortParam,
                          child: Text(
                            sortParam.name,
                            style: const TextStyle(color: Colors.white),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        sortParameter = value ?? SortParameter.bestSeller;
                      });
                      widget.onSortParamSelect(sortParameter);
                    },
                  ),
                ),
              ],
            ),
            const FilterButton()
          ],
        ),
      );
    });
  }
}

class UpDownSort extends StatefulWidget {
  final Function(SortOrder) onSortTap;

  const UpDownSort({
    required this.onSortTap,
    Key? key,
  }) : super(key: key);

  @override
  State<UpDownSort> createState() => _UpDownSortState();
}

class _UpDownSortState extends State<UpDownSort> {
  SortOrder sortOrder = SortOrder.asc;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      onPressed: () {
        setState(() {
          if (sortOrder == SortOrder.asc) {
            sortOrder = SortOrder.desc;
          } else {
            sortOrder = SortOrder.asc;
          }
        });

        widget.onSortTap(sortOrder);
      },
      icon: Icon(
        sortOrder == SortOrder.asc ? CupertinoIcons.sort_down : CupertinoIcons.sort_up,
        color: Colors.white,
      ),
    );
  }
}

enum SortOrder { asc, desc }

extension SortOrderExtension on SortOrder {
  String get value {
    switch (this) {
      case SortOrder.asc:
        return "ASC";
      case SortOrder.desc:
        return "DESC";
      default:
        return "ASC";
    }
  }
}

enum SortParameter {
  latestProduct,
  bestSeller,
  priceLowToHigh,
  priceHighToLow,
  mostReviewed,
}

extension SortParametersExt on SortParameter {
  String get name {
    switch (this) {
      case SortParameter.latestProduct:
        return "Latest Products";
      case SortParameter.bestSeller:
        return "Best Sellers";
      case SortParameter.priceLowToHigh:
        return "Price Low to High";
      case SortParameter.priceHighToLow:
        return "Price High to Low";
      case SortParameter.mostReviewed:
        return "Most Reviewed";
      default:
        return "pricelow";
    }
  }

  String get value {
    switch (this) {
      case SortParameter.latestProduct:
        return "new";
      case SortParameter.bestSeller:
        return "trending";
      case SortParameter.priceLowToHigh:
        return "pricelow";
      case SortParameter.priceHighToLow:
        return "pricehigh";
      case SortParameter.mostReviewed:
        return "featured";
      default:
        return "pricelow";
    }
  }
}
