import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/widgets/snackbar.dart';
import 'package:yeshelpinghand/core/presentation/widgets/toast.dart';
import 'package:yeshelpinghand/features/reviews/data/model/review_params.dart';
import 'package:yeshelpinghand/features/reviews/domain/repository/review_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/widgets/loading_dialog.dart';

class ReviewController extends GetxController {
  late GlobalKey<FormState> reviewFormKey;

  @override
  void onInit() {
    reviewFormKey = GlobalKey<FormState>();
    super.onInit();
  }

  ReviewParams reviewParams = ReviewParams();

  addProductReview(
      BuildContext context, String id, ReviewParams reviewParams) async {
    // final normalizedReviews = normalizeRatings(reviewParams);
    showLoadingDialog(context);
    final result =
        await Get.find<ReviewRepository>().addProductReview(id, reviewParams);
    hideLoadingDialog(context);
    if (result.hasData) {
      showToast(result.data);
    } else if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
  }

/***** IF RATING NORMALIZATION IS REQUIRED USE THIS CODE *****/
  // ReviewParams normalizeRatings(ReviewParams reviewParams) {
  //   final maxServerRatings = 100;
  //   final maxCurrentRatings = 5;
  //   final normalizingValue = maxServerRatings ~/ maxCurrentRatings;
  //   final normalizedReview = ReviewParams()
  //     ..qualityRating = reviewParams.qualityRating * normalizingValue
  //     ..priceRating = reviewParams.priceRating * normalizingValue
  //     ..valueRating = reviewParams.valueRating * normalizingValue
  //     ..nickname = reviewParams.nickname
  //     ..summary = reviewParams.summary
  //     ..review = reviewParams.review;
  //
  //   return normalizedReview;
  // }
}
