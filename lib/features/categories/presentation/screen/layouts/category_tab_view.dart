import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/cached_network_image_builder.dart';
import 'package:yeshelpinghand/core/utils/string_capitalize.dart';
import 'package:yeshelpinghand/features/categories/data/models/response/category.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/widgets/base_widget.dart';

class CategoryTabView extends StatelessWidget {
  final Category category;

  const CategoryTabView({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Expanded(
        child: Stack(
          children: [
            Positioned(
                top: 10,
                right: 20,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        StringCapitalize.capitalizeSentence('${category.name}'),
                        style: theme.textTheme.caption?.copyWith(fontSize: 10),
                      ),
                      const Icon(Icons.keyboard_double_arrow_right),
                    ],
                  ),
                )),
          ],
        ),
      );
    });
  }
}

class SubCategorySection extends StatelessWidget {
  const SubCategorySection({
    Key? key,
    required this.subCategory,
  }) : super(key: key);

  final SubCategory subCategory;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.productListingScreen,
                    arguments: FilterQueryParams(categoryId: subCategory.id));
              },
              child: Text(
                StringCapitalize.capitalizeSentence('${subCategory.name}'),
                style: theme.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            config.verticalSpaceMedium(),
            subCategory.subCategoryChildren?.isEmpty == true
                ? config.verticalSpaceCustom(0.15)
                : Wrap(
                    children: List.generate(subCategory.subCategoryChildren?.length ?? 0, (index) {
                      final subCategoryChild = subCategory.subCategoryChildren![index];

                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.productListingScreen,
                              arguments: FilterQueryParams(categoryId: subCategoryChild.id));
                        },
                        child: SubCategoryChildCard(subCategoryChild: subCategoryChild),
                      );
                    }),
                  ),
          ],
        ),
      );
    });
  }
}

class SubCategoryChildCard extends StatelessWidget {
  const SubCategoryChildCard({
    Key? key,
    required this.subCategoryChild,
  }) : super(key: key);

  final SubCategoryChild subCategoryChild;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Container(
        width: config.appWidth(17),
        margin: EdgeInsets.only(
          bottom: config.appVerticalPaddingMedium(),
          right: config.appHorizontalPaddingLarge(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            subCategoryChild.image != null
                ? SizedBox(
                    child: CustomCachedNetworkImage(
                      "${subCategoryChild.image}",
                    ),
                    width: config.appWidth(15),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: config.appHorizontalPaddingLarge(),
                        vertical: config.appVerticalPadding(1.5)),
                    decoration: BoxDecoration(
                        color: theme.primaryColor, borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "${subCategoryChild.name?.substring(0, 1)}",
                      style: theme.textTheme.bodyText1?.copyWith(color: Colors.white),
                    ),
                  ),
            config.verticalSpaceSmall(),
            Text(
              StringCapitalize.capitalizeSentence('${subCategoryChild.name}'),
              style: theme.textTheme.bodyText2,
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    });
  }
}
