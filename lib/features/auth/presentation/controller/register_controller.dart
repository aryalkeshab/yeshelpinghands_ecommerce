import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/features/auth/data/models/request/register_params.dart';
import 'package:yeshelpinghand/features/auth/domain/repository/register_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/data/data_source/remote/api_result.dart';
import '../../../../core/presentation/widgets/loading_dialog.dart';
import '../../../../core/presentation/widgets/snackbar.dart';
import '../../../../core/presentation/widgets/toast.dart';

class RegisterController extends GetxController {
  late RegisterRepository registerRepository;

  @override
  void onInit() {
    registerRepository = Get.find<RegisterRepository>();
    super.onInit();
  }

  late ApiResponse registerResponse;

  void requestRegister(
      RegisterParams registerParams, BuildContext context) async {
    showLoadingDialog(context);
    registerResponse = await registerRepository.register(registerParams);
    hideLoadingDialog(context);
    if (registerResponse.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(registerResponse.error));
    } else {
      showToast(registerResponse.data);
      Get.back();
    }
  }
}
