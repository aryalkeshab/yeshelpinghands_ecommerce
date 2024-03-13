import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/cached_network_image_builder.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/featured_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/request/image_slider_response.dart';

class FeaturedCategorySection extends StatelessWidget {
  const FeaturedCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeaturedCategoryController>(builder: (controller) {
      final result = controller.featuredCategoryApiResponse;
      final featuredCategoryList = result.data;
      return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: BaseWidget(builder: (context, config, theme) {
            if (result.hasData) {
              return Row(
                  children: List.generate(featuredCategoryList.length, (index) {
                final BannerResponse featuredCategory = featuredCategoryList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Row(
                    children: [
                      SizedBox(
                          height: 85, child: CustomCachedNetworkImage("${featuredCategory.image}")),
                      config.horizontalSpaceMedium()
                    ],
                  ),
                );
              }));
            } else if (result.hasError) {
              return const SizedBox.shrink();
            } else {
              return Row(
                children: List.generate(6, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ShimmerWidget.rounded(
                        height: 80,
                        width: MediaQuery.of(context).size.width / 5.7,
                        borderRadius: 8),
                  );
                }),
              );
            }
          }));
    });
  }
}
