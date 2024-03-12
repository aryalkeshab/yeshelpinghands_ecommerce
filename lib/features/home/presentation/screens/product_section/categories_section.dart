import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/features/categories/presentation/controller/category_controller.dart';

import '../../../../../core/data/data_source/remote/api_constants.dart';
import '../../../../../core/presentation/routes/app_pages.dart';
import '../../../../../core/presentation/widgets/base_widget.dart';
import '../../../../../core/presentation/widgets/cached_network_image_builder.dart';
import '../../../../../core/presentation/widgets/shimmer_widget.dart';
import '../../../../categories/data/models/response/category.dart';
import '../../../../product/data/model/request/filter_query_params.dart';
import '../shared/layouts.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (controller) {
      final result = controller.categoryApiResponse;
      if (result.hasData) {
        return Container(
            child: Column(
          children: [
            SectionHeader(title: "Categories", showViewAll: false, onViewAllProductTap: () {}),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: HookBaseWidget(builder: (context, config, theme) {
                final selectedCategoryId = useState(0);
                final List<Category> categoryList = result.data;
                return Row(
                  children: List.generate(categoryList.length, (index) {
                    final category = categoryList[index];
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectedCategoryId.value = category.id;
                            Get.toNamed(Routes.productListingScreen,
                                arguments: FilterQueryParams(categoryId: category.id));
                          },
                          child: Container(
                            height: config.appHeight(12),
                            width: config.appWidth(18),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20), color: Colors.grey[50]
                                //  color: Colors.red
                                ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  child: ClipOval(
                                    child: CustomCachedNetworkImage(
                                      isCompleteUrl: true,
                                      "${APIPathHelper.baseUrlImage + category.image}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${category.name}',
                                  style: theme.textTheme.bodyText2
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        config.horizontalSpaceSmall(),
                      ],
                    );
                  }),
                );
              }),
            ),
          ],
        ));
      } else {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ShimmerWidget.rounded(height: 150, width: 120, borderRadius: 5),
              );
            }),
          ),
        );
      }
    });
  }
}
