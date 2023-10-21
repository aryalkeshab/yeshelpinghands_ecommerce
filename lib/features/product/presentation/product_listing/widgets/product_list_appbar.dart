import 'package:yeshelpinghand/core/presentation/resources/colors.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/features/cart/data/model/response/cart_details.dart';
import 'package:yeshelpinghand/features/cart/presentation/controller/cart_controller.dart';
import 'package:yeshelpinghand/features/dashboard/controllers/dashboard_controller.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import 'package:yeshelpinghand/features/product/presentation/product_listing/product_listing_screen.dart';
import '../../../../../core/presentation/widgets/base_widget.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../cart/presentation/screen/cart_screen.dart';
import '../../../../cart/presentation/screen/empty_cart_screen.dart';
import '../../../../shared/layouts/auth_widget_wrapper.dart';

class ProductListingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Function(FilterQueryParams Function(FilterQueryParams)) onSortUpdate;

  ProductListingAppBar({required this.onSortUpdate});

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig(context);
    final themeData = Theme.of(context);
    return AppBar(
      elevation: 1,
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
          child: Padding(
              padding:
                  EdgeInsets.only(bottom: config.appVerticalPaddingMedium()),
              child: _SortHeading(
                onSortParamSelect: (sortParam) {
                  onSortUpdate(
                    (FilterQueryParams filterQueryParams) {
                      filterQueryParams.order ??= SortOrder.asc.value;
                      filterQueryParams.sort = sortParam.value;
                      return filterQueryParams;
                    },
                  );
                },
                onSortOrderSelect: (order) {
                  onSortUpdate(
                    (FilterQueryParams filterQueryParams) {
                      filterQueryParams.sort ??= SortParameter.position.value;
                      filterQueryParams.order = order.value;
                      return filterQueryParams;
                    },
                  );
                },
              )),
          preferredSize: const Size(double.maxFinite, 45)),
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: config.appEdgePadding()),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              // size: 20,
            ),
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: grey500,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    // ignore: avoid_redundant_argument_values
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
                        style: themeData.textTheme.bodyText2
                            ?.copyWith(color: grey500),
                        textAlign: TextAlign.left,
                      ),
                      const Spacer(),
                      config.horizontalSpaceSmall(),
                    ],
                  )),
            ),
          ),
        ),
        config.horizontalSpaceMedium(),
        Padding(
          padding: EdgeInsets.only(right: config.appHorizontalPaddingSmall()),
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
                        child: Text("${cartResponse.cartDetail?.itemsCount}",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: Colors.white)),
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
        config.horizontalSpaceMedium(),
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
  SortParameter sortParameter = SortParameter.position;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: config.appEdgePadding()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                UpDownSort(
                  onSortTap: widget.onSortOrderSelect,
                ),
                config.horizontalSpaceSmall(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: DropdownButton<SortParameter>(
                    dropdownColor: theme.primaryColor,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    elevation: 0,
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
                        sortParameter = value ?? SortParameter.position;
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
        sortOrder == SortOrder.asc
            ? CupertinoIcons.sort_down
            : CupertinoIcons.sort_up,
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

enum SortParameter { position, name, price }

extension SortParametersExt on SortParameter {
  String get name {
    switch (this) {
      case SortParameter.position:
        return "Position";
      case SortParameter.name:
        return "Name";
      case SortParameter.price:
        return "Price";
      default:
        return "Position";
    }
  }

  String get value {
    switch (this) {
      case SortParameter.position:
        return "created_at";
      case SortParameter.name:
        return "name";
      case SortParameter.price:
        return "price";
      default:
        return "created_at";
    }
  }
}
