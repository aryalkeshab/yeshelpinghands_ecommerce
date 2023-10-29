import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/features/categories/data/models/response/category.dart';
import 'package:yeshelpinghand/features/categories/presentation/controller/category_controller.dart';
import 'package:yeshelpinghand/features/categories/presentation/screen/layouts/category_loading_view.dart';
import 'package:yeshelpinghand/features/categories/presentation/screen/layouts/category_tab_view.dart';
import 'package:yeshelpinghand/features/categories/presentation/screen/layouts/category_vertical_tabs.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';

import '../../../../core/data/data_source/remote/api_constants.dart';
import '../../../../core/presentation/widgets/cached_network_image_builder.dart';
import '../../../shared/layouts/appbar_home.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Categories', style: TextStyle(fontSize: 16)),
        // title: Column(
        //   children: [
        //     SearchBarContainer(
        //       onPressed: () {
        //         Get.toNamed(Routes.search);
        //       },
        //     ),
        //   ],
        // ),
      ),
      body: const CategoryBody(),
    );
  }
}

class CategoryBody extends StatelessWidget {
  const CategoryBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
        init: CategoryController(),
        builder: (controller) {
          return HookBaseWidget(builder: (context, config, theme) {
            final selectedCategoryId = useState(0);
            final result = Get.find<CategoryController>().categoryApiResponse;
            if (result.hasData) {
              final List<Category> categoryList = result.data;

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: config.appEdgePadding(),
                  vertical: config.appHorizontalPaddingSmall(),
                ),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
                      childAspectRatio: 3.85 / 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    final category = categoryList[index];
                    return Container(
                      decoration: BoxDecoration(
                          // color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: theme.primaryColor,
                            width: 1,
                          )),
                      child: InkWell(
                        onTap: () {
                          // Handle the category item tap here
                          selectedCategoryId.value = category.id;
                          Get.toNamed(Routes.productListingScreen,
                              arguments:
                                  FilterQueryParams(categoryId: category.id));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomCachedNetworkImage(
                              isCompleteUrl: true,
                              "${APIPathHelper.baseUrlImage + category.image}",
                              fit: BoxFit.cover,
                            ),
                            // Divider(),
                            // // config.verticalSpaceSmall(),
                            // Text(category.name,
                            //     style: TextStyle(
                            //         color: Colors.black,
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (result.hasError) {
              return Center(
                child: ErrorView(
                  title: NetworkException.getErrorMessage(result.error),
                ),
              );
            } else {
              return const CategoryLoadingView();
            }
          });
        });
  }
}

/*

SmartRefresher(
            controller: controller.refreshController,
            header: const WaterDropHeader(),
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: () => controller.fetchCategoryList(),
            child:
 */