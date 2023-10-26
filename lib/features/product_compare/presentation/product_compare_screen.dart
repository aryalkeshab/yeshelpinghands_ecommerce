import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/resources/ui_assets.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/core/presentation/widgets/circular_cached_network_image_builder.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/core/utils/constants.dart';
import 'package:yeshelpinghand/features/product_compare/presentation/controller/compare_products_controller.dart';
import 'package:yeshelpinghand/features/shared/layouts/confirm_dialog_view.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/presentation/resources/colors.dart';
import '../../../core/presentation/routes/app_pages.dart';
import '../../../core/utils/number_parser.dart';
import '../../cart/data/model/request/cart_request_params.dart';
import '../../cart/presentation/controller/cart_controller.dart';

class ProductCompareScreen extends StatefulWidget {
  const ProductCompareScreen({Key? key}) : super(key: key);

  @override
  State<ProductCompareScreen> createState() => _ProductCompareScreenState();
}

class _ProductCompareScreenState extends State<ProductCompareScreen> {
  @override
  void initState() {
    Get.find<CompareProductsController>().fetchCompareProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Product Compare"),
        ),
        body: GetBuilder<CompareProductsController>(builder: (controller) {
          final result = controller.productCompareResponse;
          if (result.hasData) {
            final CompareProductsEntity compareProductsEntity = result.data;
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: config.appEdgePadding(),
                  vertical: config.appVerticalPaddingMedium()),
              child: Builder(builder: (context) {
                if (compareProductsEntity.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: config.appHorizontalPaddingMedium(),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                compareProductsEntity.names.length,
                                (index) => Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(Routes.productDetails,
                                                arguments: compareProductsEntity
                                                    .sku[index]);
                                          },
                                          child: Container(
                                            width: config.appWidth(35),
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  width: config.appWidth(35),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                          child: CircularCachedNetworkImageBuilder(
                                                              isBorderEnabled:
                                                                  false,
                                                              borderRadius: 5,
                                                              imageUrl:
                                                                  "${APIPathHelper.baseUrl}$imagePrefix${compareProductsEntity.images[index]}")),
                                                      // ${APIPathHelper.baseUrl}$imagePrefix
                                                      //     imageUrl:
                                                      // "${APIPathHelper.baseUrl}$imagePrefix${compareProductsEntity.images[index]}"
                                                      config
                                                          .verticalSpaceMedium(),
                                                      Text(
                                                          "${compareProductsEntity.names[index]}",
                                                          style: theme.textTheme
                                                              .bodyText2),
                                                      config
                                                          .verticalSpaceSmall(),
                                                      Text(
                                                          "$currency ${NumberParser.twoDecimalDigit(compareProductsEntity.price[index])}",
                                                          style: theme.textTheme
                                                              .bodyText1
                                                              ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          )),
                                                      PrimaryOutlinedButton(
                                                          height:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.04,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                          borderColor:
                                                              compareProductsEntity
                                                                              .availability[
                                                                          index] ==
                                                                      'IN STOCK'
                                                                  ? primaryColor
                                                                  : lightGreen,
                                                          title: compareProductsEntity
                                                                          .availability[
                                                                      index] ==
                                                                  'IN STOCK'
                                                              ? "Add to Cart"
                                                              : "Out of Stock",
                                                          onPressed: () {}
                                                          // compareProductsEntity
                                                          //                 .availability[
                                                          //             index] ==
                                                          //         'IN STOCK'
                                                          //     ? () {
                                                          //         Get.find<CartController>().addToCart(
                                                          //             context,
                                                          //             CartParams(
                                                          //                 sku:
                                                          //                     compareProductsEntity.sku[index],
                                                          //                 qty: 1));
                                                          //       }
                                                          //     : () {},
                                                          ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                    alignment: index == 0
                                                        ? Alignment.topLeft
                                                        : Alignment.topRight,
                                                    child: InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return ConfirmDialogView(
                                                              primaryText:
                                                                  "Are you sure you want to remove this product from product compare list?",
                                                              onApproveButtonPressed:
                                                                  () {
                                                                Get.find<
                                                                        CompareProductsController>()
                                                                    .deleteCompareProduct(
                                                                        context,
                                                                        compareProductsEntity
                                                                            .ids[index]);
                                                                Get.back();
                                                              },
                                                              onCancelButtonPressed:
                                                                  Get.back,
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: theme
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2)),
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 20,
                                                          color: theme
                                                              .colorScheme
                                                              .onPrimary,
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (compareProductsEntity
                                                    .names.length ==
                                                2 &&
                                            index == 0)
                                          Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                  color: theme.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                "vs",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                        color: Colors.white),
                                              ))
                                      ],
                                    )),
                          ),
                        ),
                        config.verticalSpaceMedium(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: config.appHorizontalPaddingSmall(),
                              vertical: config.appVerticalPaddingSmall()),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Table(
                            border: TableBorder.symmetric(
                                // inside: BorderSide(color: Colors.grey.shade100),
                                ),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(1.5),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(2),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: List.generate(
                                compareProductsEntity.attributes.length,
                                (index) {
                              final attribute =
                                  compareProductsEntity.attributes[index];
                              return TableRow(
                                children: <Widget>[
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.top,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: Text("${attribute.attributeName}",
                                          style: theme.textTheme.caption
                                              ?.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)),
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.top,
                                    child: Container(
                                      // color: Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: Text(
                                          "${attribute.attributeValue[0]}",
                                          style: theme.textTheme.caption
                                              ?.copyWith(color: Colors.grey)),
                                    ),
                                  ),
                                  if (compareProductsEntity.names.length > 1)
                                    TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.top,
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          // color: Colors.red,
                                          child: Text(
                                              "${attribute.attributeValue[1]}",
                                              style: theme.textTheme.caption
                                                  ?.copyWith(
                                                      color: Colors.grey))),
                                    ),
                                ],
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(UIAssets.emptyBoxRed, width: 100),
                        config.verticalSpaceMedium(),
                        Text("Your product compare list is empty",
                            style: theme.textTheme.bodyText1
                                ?.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  );
                }
              }),
            );
          } else if (result.hasError) {
            return Center(
              child: ErrorView(
                title: NetworkException.getErrorMessage(result.error),
              ),
            );
          } else {
            return BaseWidget(builder: (context, config, theme) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: config.appVerticalPaddingMedium(),
                  horizontal: config.appEdgePadding(),
                ),
                child: Column(
                  children: [
                    Center(
                      child: ShimmerWidget.rounded(
                          width: config.appWidth(40),
                          height: config.appWidth(50)),
                    ),
                    config.verticalSpaceMedium(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                              bottom: config.appVerticalPaddingSmall()),
                          child: ShimmerWidget.rounded(
                              width: config.appWidth(100),
                              height: config.appHeight(4)),
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
          }
        }),
      );
    });
  }
}
