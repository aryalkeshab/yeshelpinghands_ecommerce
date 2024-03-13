import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/data/data_source/remote/api_result.dart';
import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../../core/presentation/widgets/loading_dialog.dart';
import '../../../../core/presentation/widgets/snackbar.dart';
import '../../../../core/presentation/widgets/toast.dart';
import '../../data/models/request/login_params.dart';
import '../../domain/repository/login_repository.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  late LoginRepository loginRepository;

  @override
  void onInit() {
    loginRepository = Get.find<LoginRepository>();
    super.onInit();
  }

  late ApiResponse loginResponse;

  void requestLogin(LoginParams loginParams, BuildContext context) async {
    showLoadingDialog(context);
    loginResponse = await loginRepository.login(loginParams);
    hideLoadingDialog(context);
    if (loginResponse.hasError) {
      AppSnackbar.showError(
          context: context, message: NetworkException.getErrorMessage(loginResponse.error));
    } else {
      showToast(loginResponse.data);
      Get.find<AuthController>().authorize();
      Get.back();
    }
  }

  void loginWithGoogle(BuildContext context) async {
    final loginResponse = await loginRepository.loginWithGoogle();
    if (loginResponse.hasError) {
    } else {
      showToast(loginResponse.data);
      Get.find<AuthController>().authorize();
    }
  }

  void loginWithFacebook(BuildContext context) async {
    final loginResponse = await loginRepository.loginWithFacebook();
    if (loginResponse.hasError) {
    } else {
      showToast(loginResponse.data);
      Get.find<AuthController>().authorize();
    }
  }
}
