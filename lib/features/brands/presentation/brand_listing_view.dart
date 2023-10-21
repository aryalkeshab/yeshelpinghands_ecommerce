import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/cached_network_image_builder.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/features/brands/data/model/response/brands_model.dart';
import 'package:yeshelpinghand/features/brands/presentation/controller/brands_controller.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';

class BrandListingView extends StatelessWidget {
  const BrandListingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return SizedBox(
        height: 150,
        child: GetBuilder<BrandsController>(builder: (controller) {
          final result = controller.brandsApiResponse;
          if (result.hasData) {
            final List<Brand> brandList = result.data;
            return GridView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              semanticChildCount: brandList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: List.generate(brandList.length, (index) {
                final brand = brandList[index];

                return CustomCachedNetworkImage(
                  "${brand.image}",
                  fit: BoxFit.contain,
                );
              }),
            );
          } else if (result.hasError) {
            return ErrorView(
              title: NetworkException.getErrorMessage(result.error),
            );
          } else {
            return ShimmerWidget.rounded(width: 100);
          }
        }),
      );
    });
  }
}
