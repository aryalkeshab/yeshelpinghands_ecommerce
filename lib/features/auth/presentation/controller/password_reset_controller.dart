import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/auth/domain/repository/password_reset_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../../core/presentation/widgets/loading_dialog.dart';
import '../../../../core/presentation/widgets/snackbar.dart';
import '../../../../core/presentation/widgets/toast.dart';

class PasswordResetController extends GetxController {
  late ApiResponse passwordResetResponse;

  resetPassword(BuildContext context, String email) async {
    showLoadingDialog(context);

    passwordResetResponse =
        await Get.find<PasswordResetRepository>().resetPassword(email: email);
    hideLoadingDialog(context);
    if (passwordResetResponse.hasError) {
      AppSnackbar.showError(
          context: context,
          message:
              NetworkException.getErrorMessage(passwordResetResponse.error));
    } else {
      showToast(passwordResetResponse.data);
      Get.back();
    }
  }
}
