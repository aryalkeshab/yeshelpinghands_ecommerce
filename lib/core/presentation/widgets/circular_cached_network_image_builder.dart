import 'package:flutter/material.dart';

import 'cached_network_image_builder.dart';

class CircularCachedNetworkImageBuilder extends StatelessWidget {
  final String imageUrl;
  final bool isBorderEnabled;
  final double? borderRadius;
  final BoxFit fit;

  const CircularCachedNetworkImageBuilder({
    this.isBorderEnabled = true,
    required this.imageUrl,
    this.borderRadius,
    this.fit = BoxFit.cover,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 100),
            child: AspectRatio(
              aspectRatio: 1,
              child: CustomCachedNetworkImage(
                imageUrl,
                fit: fit,
              ),
            )));
  }
}
