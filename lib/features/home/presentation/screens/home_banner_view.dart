import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/circular_cached_network_image_builder.dart';
import 'package:yeshelpinghand/features/home/presentation/controller/home_banner_controller.dart';

import '../../../../core/presentation/widgets/shimmer_widget.dart';

class SingleBannerView extends StatelessWidget {
  const SingleBannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return GetBuilder<HomeBannerController>(builder: (controller) {
        final result = controller.singleBannerResponse;

        if (result.hasData) {
          final bannerResponse = result.data;
          return SizedBox(
            height: config.appHeight(15),
            child: CircularCachedNetworkImageBuilder(
              imageUrl: bannerResponse.link,
              borderRadius: 5,
            ),
          );
        } else if (result.hasError) {
          return const SizedBox.shrink();
          // return ErrorView(title: NetworkException.getErrorMessage(result.error));
        } else {
          return ShimmerWidget.rounded(
              height: 120, width: MediaQuery.of(context).size.width / 1.18, borderRadius: 0);
        }
      });
    });
  }
}

class MultiBannerView extends StatelessWidget {
  const MultiBannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return GetBuilder<HomeBannerController>(builder: (controller) {
        final result = controller.bannerListResponse;

        if (result.hasData) {
          final bannerResponseList = result.data;
          return SizedBox(
            height: config.appHeight(15),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => config.horizontalSpaceSmall(),
                scrollDirection: Axis.horizontal,
                itemCount: bannerResponseList.length,
                itemBuilder: (context, index) => SizedBox(
                      width: config.appWidth(90),
                      child: CircularCachedNetworkImageBuilder(
                          borderRadius: 5,
                          isBorderEnabled: false,
                          // fit: BoxFit.fill,
                          imageUrl: APIPathHelper.baseUrlImage + bannerResponseList[index].image),
                    )),
          );
        } else if (result.hasError) {
          return const SizedBox.shrink();
          // return ErrorView(title: NetworkException.getErrorMessage(result.error));
        } else {
          return ShimmerWidget.rounded(
              height: 120, width: MediaQuery.of(context).size.width / 1.18, borderRadius: 0);
        }
      });
    });
  }
}
