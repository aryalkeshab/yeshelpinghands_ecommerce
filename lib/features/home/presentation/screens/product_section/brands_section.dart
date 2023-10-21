import 'package:flutter/material.dart';
import 'package:yeshelpinghand/features/brands/presentation/brand_listing_view.dart';
import 'package:yeshelpinghand/features/home/presentation/screens/shared/layouts.dart';

class HomeBrandSection extends StatelessWidget {
  const HomeBrandSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionHeader(
          title: "Top Brands",
          onViewAllProductTap: () {},
          showViewAll: false,
        ),
        const BrandListingView(),
      ],
    );
  }
}
