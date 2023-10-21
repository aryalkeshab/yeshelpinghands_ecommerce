import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/auth/data/models/request/update_password_params.dart';
import 'package:yeshelpinghand/features/auth/domain/repository/password_update_repository.dart';
import 'package:yeshelpinghand/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../../core/presentation/routes/app_pages.dart';
import '../../../../core/presentation/widgets/loading_dialog.dart';
import '../../../../core/presentation/widgets/snackbar.dart';
import '../../../../core/presentation/widgets/toast.dart';

class PasswordUpdateController extends GetxController {
  late ApiResponse passwordUpdateResponse;

  updatePassword(
      BuildContext context, UpdatePasswordParams updatePasswordParams) async {
    showLoadingDialog(context);

    passwordUpdateResponse = await Get.find<PasswordUpdateRepository>()
        .updatePassword(updatePasswordParams);
    hideLoadingDialog(context);
    if (passwordUpdateResponse.hasError) {
      AppSnackbar.showError(
          context: context,
          message:
              NetworkException.getErrorMessage(passwordUpdateResponse.error));
    } else {
      Get.find<AuthController>().logout();
      showToast(passwordUpdateResponse.data);
      Get.until((route) => route.settings.name == Routes.dashboard);
    }
  }
}
