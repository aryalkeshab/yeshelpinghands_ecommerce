import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/utils/date_formatter_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../product/data/model/response/product_details.dart';
import '../../../../product/presentation/product_details/widgets/product_details_view.dart';

class ReviewsAndRatings extends StatelessWidget {
  const ReviewsAndRatings({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  final List<Review>? reviews;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductDetailsSectionHeading(
              title: "REVIEWS AND RATINGS (${reviews?.length ?? 0})"),
          Column(
            children: List.generate(reviews?.length ?? 0, (index) {
              final review = reviews![index];
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(5),
                margin: EdgeInsets.only(top: config.appVerticalPaddingSmall()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "${review.userName}  ",
                          style: theme.textTheme.caption),
                      TextSpan(
                          text:
                              "-${DateFormatterUtils.formatDateFromString("${review.createdAt}")}",
                          style: theme.textTheme.caption),
                    ])),
                    config.verticalSpaceSmall(),
                    Text("${review.title}",
                        style: theme.textTheme.bodyText2
                            ?.copyWith(fontWeight: FontWeight.w500)),
                    config.verticalSpaceSmall(),
                    Text("${review.details}",
                        style: theme.textTheme.bodyText2?.copyWith(height: 1.2),
                        textAlign: TextAlign.justify),
                    config.verticalSpaceSmall(),
                    ProductRatingsView(review: review),
                  ],
                ),
              );
            }),
          )
        ],
      );
    });
  }
}

class ProductRatingsView extends StatelessWidget {
  const ProductRatingsView({
    Key? key,
    required this.review,
  }) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProductRatingAttribute(
          title: "Price",
          value: review.ratings?.price,
        ),
        ProductRatingAttribute(
          title: "Quality",
          value: review.ratings?.quality,
        ),
        ProductRatingAttribute(
          title: "Value",
          value: review.ratings?.value,
        ),
      ],
    );
  }
}

class ProductRatingAttribute extends StatelessWidget {
  final String title;
  final String? value;

  const ProductRatingAttribute({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingsBuilder(value: value),
        Text(
          title,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

class RatingsBuilder extends StatelessWidget {
  const RatingsBuilder({
    Key? key,
    this.value,
    this.onRatingSelection,
    this.itemSize = 14,
  }) : super(key: key);

  final String? value;
  final double itemSize;
  final void Function(double value)? onRatingSelection;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      // ignoreGestures: onRatingSelection == null,
      itemSize: itemSize,
      initialRating: (double.tryParse("$value") ?? 0) * 0.05,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: onRatingSelection ?? (value) {},
    );
  }
}
