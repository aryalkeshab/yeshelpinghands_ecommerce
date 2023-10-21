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
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';

import '../../../shared/layouts/appbar_home.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            SearchBarContainer(
              onPressed: () {
                Get.toNamed(Routes.search);
              },
            ),
          ],
        ),
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
              // categoryList.sort((a, b) => a.name!.compareTo(b.name!));
              // categoryList.sort((a, b) {
              //   final nameA = a.name!;
              //   final nameB = b.name!;

              //   final nameAChars = Characters(nameA.toLowerCase());
              //   final nameBChars = Characters(nameB.toLowerCase());

              //   final nameAIterator = nameAChars.iterator;
              //   final nameBIterator = nameBChars.iterator;

              //   while (nameAIterator.moveNext() && nameBIterator.moveNext()) {
              //     final charA = nameAIterator.current;
              //     final charB = nameBIterator.current;

              //     final comparisonResult = charA.compareTo(charB);
              //     if (comparisonResult != 0) {
              //       return comparisonResult;
              //     }
              //   }

              //   return nameAChars.length.compareTo(nameBChars.length);
              // });
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: config.appEdgePadding(),
                  vertical: config.appHorizontalPaddingSmall(),
                ),
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width / 3.5,
                        childAspectRatio: 4 / 5,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return Container(
                          height: 300,
                          decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: InkWell(
                            onTap: () {},
                            child: Center(child: Text("Herllo")),
                          ));
                    },
                    itemCount: categoryList.length),
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