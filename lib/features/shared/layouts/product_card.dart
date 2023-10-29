import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/utils/constants.dart';
import 'package:yeshelpinghand/features/product/utils/emi_utils.dart';

import '../../../core/presentation/resources/colors.dart';
import '../../../core/presentation/routes/app_pages.dart';
import '../../../core/presentation/widgets/cached_network_image_builder.dart';
import '../../../core/utils/number_parser.dart';
import '../../home/data/models/response/products_model.dart';

enum _ProductCardType {
  small,
  large,
}

class ProductCard {
  static _ProductCard small({
    required ProductModel productModel,
    VoidCallback? onCartButtonClick,
    VoidCallback? onWishlistButtonClick,
  }) =>
      _ProductCard(
        productModel: productModel,
        type: _ProductCardType.small,
        onCartButtonClick: onCartButtonClick,
        onWishlistButtonClick: onWishlistButtonClick,
      );

  static _ProductCard large({
    required ProductModel productModel,
    VoidCallback? onCartButtonClick,
    VoidCallback? onWishlistButtonClick,
  }) =>
      _ProductCard(
        productModel: productModel,
        type: _ProductCardType.large,
        onCartButtonClick: onWishlistButtonClick,
        onWishlistButtonClick: onWishlistButtonClick,
      );
}

class _ProductCard extends StatelessWidget {
  final ProductModel productModel;
  final VoidCallback? onCartButtonClick;
  final VoidCallback? onWishlistButtonClick;
  final Color? decorationColor;
  final _ProductCardType? type;

  const _ProductCard({
    Key? key,
    this.type = _ProductCardType.small,
    required this.productModel,
    this.decorationColor,
    this.onWishlistButtonClick,
    this.onCartButtonClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Container(
        width: type == _ProductCardType.large ? 150 : 115,
        decoration: BoxDecoration(
          border: Border.all(
              color: decorationColor ?? Colors.grey.withOpacity(0.0)),
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.productDetails,
                    arguments: productModel.slug);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: type == _ProductCardType.large ? 140 : 98,
                    child: CustomCachedNetworkImage(
                      isCompleteUrl: false,
                      productModel.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                  config.verticalSpaceSmall(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: config.appHorizontalPaddingSmall()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${productModel.name?.capitalize}',
                          style: theme.textTheme.bodyText2
                              ?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        config.verticalSpaceVerySmall(),
                        Text(
                          "$currency ${NumberParser.twoDecimalDigit(productModel.price.toString())}",
                          style: theme.textTheme.bodyText1?.copyWith(
                              color: primaryColor2,
                              fontWeight: FontWeight.w600,
                              decoration: productModel.offerPrice > 0 &&
                                      productModel.offerPrice <
                                          productModel.price
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        if (productModel.offerPrice > 0 &&
                            productModel.offerPrice < productModel.price)
                          Text(
                            "$currency ${NumberParser.twoDecimalDigit(productModel.offerPrice.toString())}",
                            style: theme.textTheme.bodyText1?.copyWith(
                              color: primaryColor2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        if (productModel.offerPrice > 0 &&
                            productModel.offerPrice < productModel.price)
                          config.verticalSpaceMedium(),
                        // config.verticalSpaceVerySmall(),
                        // ProductEmi(
                        //   price: price,
                        // ),
                        // config.verticalSpaceVerySmall(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

enum ProductEmiType { small, large }

class ProductEmi extends StatelessWidget {
  final String price;
  final ProductEmiType productEmiType;

  const ProductEmi(
      {Key? key,
      required this.price,
      this.productEmiType = ProductEmiType.small})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HookBaseWidget(builder: (context, config, theme) {
      var selectedItem = useState("30");
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
              "${calculateEmi(principle: double.tryParse(price) ?? 0, timeInMonths: int.tryParse(selectedItem.value) ?? 0)}",
              style: productEmiType == ProductEmiType.small
                  ? theme.textTheme.caption?.copyWith(color: theme.primaryColor)
                  : theme.textTheme.bodyText2
                      ?.copyWith(color: theme.primaryColor)),
          config.horizontalSpaceSmall(),
          Text("x",
              style: productEmiType == ProductEmiType.small
                  ? theme.textTheme.caption?.copyWith(color: theme.primaryColor)
                  : theme.textTheme.bodyText2
                      ?.copyWith(color: theme.primaryColor)),
          config.horizontalSpaceSmall(),
          Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down),
                elevation: 0,
                itemHeight: kMinInteractiveDimension,
                underline: const SizedBox.shrink(),
                borderRadius: BorderRadius.circular(5),
                alignment: Alignment.centerRight,
                value: selectedItem.value,
                isDense: true,
                items: ["6", "12", "18", "24", "30"]
                    .reversed
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text("$e",
                            style: productEmiType == ProductEmiType.small
                                ? theme.textTheme.caption
                                    ?.copyWith(color: theme.primaryColor)
                                : theme.textTheme.bodyText2
                                    ?.copyWith(color: theme.primaryColor))))
                    .toList(),
                onChanged: (value) {
                  selectedItem.value = value.toString();
                },
              )),

          Text(" months*",
              style: productEmiType == ProductEmiType.small
                  ? theme.textTheme.caption?.copyWith(color: theme.primaryColor)
                  : theme.textTheme.bodyText2
                      ?.copyWith(color: theme.primaryColor)),
          // Text("months*",style: theme.textTheme.caption?.copyWith(color: theme.primaryColor)),
          // DropdownButtonExample(),
        ],
      );
    });
  }
}
