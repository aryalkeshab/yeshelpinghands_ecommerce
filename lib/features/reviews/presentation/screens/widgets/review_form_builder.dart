import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/core/presentation/widgets/textfields.dart';
import 'package:yeshelpinghand/core/utils/custom_validators.dart';
import 'package:yeshelpinghand/features/product/presentation/product_details/widgets/product_details_view.dart';
import 'package:yeshelpinghand/features/reviews/presentation/controllers/review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/widgets/base_widget.dart';

class ReviewFormBuilder extends StatelessWidget {
  final String productId;

  const ReviewFormBuilder({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProductDetailsSectionHeading(title: "ADD YOUR REVIEW"),
          config.verticalSpaceSmall(),
          Form(
            key: Get.find<ReviewController>().reviewFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableRatingBar(
                  title: "Price",
                  onRatingSelection: (rating) {
                    Get.find<ReviewController>().reviewParams.priceRating =
                        rating.toInt();
                  },
                ),
                config.verticalSpaceSmall(),
                SelectableRatingBar(
                  title: "Quality",
                  onRatingSelection: (rating) {
                    Get.find<ReviewController>().reviewParams.qualityRating =
                        rating.toInt();
                  },
                ),
                config.verticalSpaceSmall(),
                SelectableRatingBar(
                  title: "Value",
                  onRatingSelection: (rating) {
                    Get.find<ReviewController>().reviewParams.valueRating =
                        rating.toInt();
                  },
                ),
                config.verticalSpaceMedium(),
                PrimaryFormField(
                    isRequired: true,
                    label: "Nickname",
                    validator: (value) => Validator.validateEmpty(value!),
                    onSaved: (value) {
                      Get.find<ReviewController>().reviewParams.nickname =
                          value;
                    }),
                config.verticalSpaceMedium(),
                PrimaryFormField(
                    isRequired: true,
                    label: "Summary",
                    validator: (value) => Validator.validateEmpty(value!),
                    onSaved: (value) {
                      Get.find<ReviewController>().reviewParams.summary = value;
                    }),
                config.verticalSpaceMedium(),
                PrimaryFormField(
                    minLines: 4,
                    maxLines: 5,
                    isRequired: true,
                    label: "Review",
                    validator: (value) => Validator.validateEmpty(value!),
                    onSaved: (value) {
                      Get.find<ReviewController>().reviewParams.review = value;
                    }),
                config.verticalSpaceMedium(),
                Align(
                  alignment: Alignment.center,
                  child: PrimaryOutlinedButton(
                      width: config.appWidth(50),
                      onPressed: () {
                        if (Get.find<ReviewController>()
                                .reviewFormKey
                                .currentState
                                ?.validate() ==
                            true) {
                          Get.find<ReviewController>()
                              .reviewFormKey
                              .currentState
                              ?.save();
                          Get.find<ReviewController>().addProductReview(
                              context,
                              productId,
                              Get.find<ReviewController>().reviewParams);
                        }
                      },
                      title: "Submit"),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
