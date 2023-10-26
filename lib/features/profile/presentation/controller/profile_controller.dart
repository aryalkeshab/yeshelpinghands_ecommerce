import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yeshelpinghand/features/auth/data/models/request/register_params.dart';
import 'package:yeshelpinghand/features/profile/data/model/request/edit_profile_params.dart';
import 'package:yeshelpinghand/features/profile/domain/repository/profile_repository.dart';
import 'package:get/get.dart';
import '../../../../core/data/data_source/remote/api_result.dart';
import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../../core/presentation/widgets/loading_dialog.dart';
import '../../../../core/presentation/widgets/snackbar.dart';
import '../../../../core/presentation/widgets/toast.dart';

class ProfileController extends GetxController {
  RefreshController refreshController = RefreshController();

  late ProfileRepository _profileRepository;

  @override
  void onInit() {
    refreshController = RefreshController();

    getUserInfoResponse();
    super.onInit();
  }

  ApiResponse _userInfoResponse = ApiResponse();

  set userInfoResponse(ApiResponse response) {
    _userInfoResponse = response;
    update();
  }

  ApiResponse get userInfoResponse => _userInfoResponse;

  getUserInfoResponse() async {
    userInfoResponse =
        await Get.find<ProfileRepository>().fetchProfileDetails();
    refreshController.refreshCompleted();
  }

  void updateCustomerInfo(
      BuildContext context, RegisterParams registerParams) async {
    showLoadingDialog(context);
    final result = await Get.find<ProfileRepository>().editProfile(
        EditProfileParams(
            name: registerParams.name,
            contactNumber: registerParams.contactNumber));

    hideLoadingDialog(context);
    if (result.hasData) {
      showToast(result.data);
      Get.back();

      getUserInfoResponse();
    } else if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
  }
}
