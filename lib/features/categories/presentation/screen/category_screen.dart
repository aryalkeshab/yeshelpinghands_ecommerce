import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/features/categories/data/models/response/category.dart';
import 'package:yeshelpinghand/features/categories/presentation/controller/category_controller.dart';
import 'package:yeshelpinghand/features/categories/presentation/screen/layouts/category_loading_view.dart';
import 'package:yeshelpinghand/features/product/data/model/request/filter_query_params.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
import '../../../../core/data/data_source/remote/api_constants.dart';
import '../../../../core/presentation/widgets/cached_network_image_builder.dart';

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
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                      childAspectRatio: 1.0,
                      //   childAspectRatio: 3.85 / 4,
                      // crossAxisSpacing: 20,
                      // mainAxisSpacing: 20
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    final category = categoryList[index];
                    return CategoryCard(
                      category: category,
                      onTap: () {
                        selectedCategoryId.value = category.id;
                        Get.toNamed(Routes.productListingScreen,
                            arguments: FilterQueryParams(categoryId: category.id));
                      },
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
class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  CategoryCard({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        // color: pasminaColor,
        elevation: 4.0,
        child: Container(
          constraints: BoxConstraints(maxHeight: 200), // Adjust the maximum height as needed
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              AspectRatio(
                aspectRatio: 4.0 / 2.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: CustomCachedNetworkImage(
                    isCompleteUrl: true,
                    "${APIPathHelper.baseUrlImage + category.image}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  category.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CategoryCard extends StatelessWidget {
//   final Category category;
//   final VoidCallback onTap;

//   CategoryCard({required this.category, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 4.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: AspectRatio(
//                 aspectRatio: 4.0 / 3.0,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(16.0),
//                     topRight: Radius.circular(16.0),
//                   ),
//                   child: Image.network(
//                     "${APIPathHelper.baseUrlImage + category.image}",
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Text(
//                 category.name,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
