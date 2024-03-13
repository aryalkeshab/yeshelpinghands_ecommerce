import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_constants.dart';

import '../resources/ui_assets.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final String? localImagePath;
  final BoxFit? fit;
  final double? aspectRatio;
  final bool isCompleteUrl;
  final bool isDetailPage;

  const CustomCachedNetworkImage(
    this.imageUrl, {
    this.localImagePath,
    Key? key,
    this.fit,
    this.aspectRatio,
    this.isCompleteUrl = true,
    this.isDetailPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: isCompleteUrl ? "$imageUrl" : "${APIPathHelper.baseUrlImage}$imageUrl",
      imageBuilder: (context, imageProvider) => AspectRatio(
        aspectRatio: aspectRatio ?? 1,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: isDetailPage ? BorderRadius.circular(0) : BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
          ),
        ),
      ),
      placeholder: (context, url) => AspectRatio(
        aspectRatio: 1,
        child: Image.asset(
          UIAssets.gifLoading,
          fit: BoxFit.cover,
        ),
      ),
      errorWidget: (context, url, error) => AspectRatio(
        aspectRatio: 1,
        child: Image.asset(
          localImagePath ?? UIAssets.placeHolderImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
