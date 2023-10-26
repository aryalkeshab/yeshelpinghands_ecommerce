import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/widgets/snackbar.dart';
import 'package:yeshelpinghand/features/address/data/model/request/address_params.dart';
import 'package:yeshelpinghand/features/address/data/model/response/address.dart';
import 'package:yeshelpinghand/features/address/domain/repository/address_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/widgets/loading_dialog.dart';
import '../../../../core/presentation/widgets/toast.dart';

class AddressController extends GetxController {
  @override
  void onInit() {
    fetchAllAddresses();
    super.onInit();
  }

  fetchAllAddresses() {
    fetchNonDefaultAddresses();
    // fetchDefaultAddresses();
  }

  Address? selectedShippingAddress;
  Address? selectedBillingAddress;

  ApiResponse _addressResponse = ApiResponse();

  set addressResponse(ApiResponse response) {
    _addressResponse = response;
    update();
  }

  ApiResponse get addressResponse => _addressResponse;

  void fetchNonDefaultAddresses() async {
    addressResponse =
        await Get.find<AddressRepository>().getNonDefaultAddresses();
  }

  void deleteAddress(BuildContext context, String id) async {
    showLoadingDialog(context);
    final result =
        await Get.find<AddressRepository>().deleteNonDefaultAddress(id);
    hideLoadingDialog(context);
    if (result.hasData) {
      showToast(result.data);
      fetchNonDefaultAddresses();
    } else if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
  }

  void updateNonDefaultAddress(
      BuildContext context, String id, AddressParams addressParams) async {
    showLoadingDialog(context);
    final result = await Get.find<AddressRepository>()
        .updateNonDefaultAddress(id, addressParams);
    hideLoadingDialog(context);
    if (result.hasData) {
      showToast(result.data);
      fetchNonDefaultAddresses();
      Get.back();
    } else if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
  }

  void addAddress(BuildContext context, AddressParams addressParams) async {
    showLoadingDialog(context);
    final result =
        await Get.find<AddressRepository>().addNonDefaultAddress(addressParams);
    hideLoadingDialog(context);
    if (result.hasData) {
      showToast(result.data);
      fetchNonDefaultAddresses();
      Get.back();
    } else if (result.hasError) {
      AppSnackbar.showError(
          context: context,
          message: NetworkException.getErrorMessage(result.error));
    }
  }

  // ApiResponse _defaultAddressesResponse = ApiResponse();

  // set defaultAddressesResponse(ApiResponse apiResponse) {
  //   _defaultAddressesResponse = apiResponse;
  //   update();
  // }

  // ApiResponse get defaultAddressesResponse => _defaultAddressesResponse;
  // bool isDefaultShippingAndBillingSame = false;

  // fetchDefaultAddresses() async {
  //   defaultAddressesResponse =
  //       await Get.find<AddressRepository>().getDefaultAddresses();
  //   if (defaultAddressesResponse.hasData) {
  //     final DefaultAddresses defaultAddresses = defaultAddressesResponse.data;
  //     if (defaultAddresses.billingAddress != null ||
  //         defaultAddresses.shippingAddress != null)
  //       isDefaultShippingAndBillingSame = defaultAddresses.billingAddress?.id ==
  //           defaultAddresses.shippingAddress?.id;
  //   }
  // }

  // void updateDefaultShippingAddress(
  //     BuildContext context, String id, AddressParams addressParams) async {
  //   showLoadingDialog(context);
  //   final result = await Get.find<AddressRepository>()
  //       .updateDefaultShippingAddress(addressParams);
  //   hideLoadingDialog(context);
  //   if (result.hasData) {
  //     showToast(result.data);
  //     // fetchDefaultAddresses();
  //     Get.back();
  //   } else if (result.hasError) {
  //     AppSnackbar.showError(
  //         context: context,
  //         message: NetworkException.getErrorMessage(result.error));
  //   }
  // }

  // void updateDefaultBillingAddress(
  //     BuildContext context, String id, AddressParams addressParams) async {
  //   showLoadingDialog(context);
  //   final result = await Get.find<AddressRepository>()
  //       .updateDefaultBillingAddress(addressParams);
  //   hideLoadingDialog(context);
  //   if (result.hasData) {
  //     showToast(result.data);
  //     // fetchDefaultAddresses();
  //     Get.back();
  //   } else if (result.hasError) {
  //     AppSnackbar.showError(
  //         context: context,
  //         message: NetworkException.getErrorMessage(result.error));
  //   }
  // }

  // setDefaultShippingAddress(BuildContext context, String id) async {
  //   showLoadingDialog(context);
  //   final result =
  //       await Get.find<AddressRepository>().setDefaultShippingAddress(id);
  //   hideLoadingDialog(context);
  //   if (result.hasData) {
  //     showToast(result.data);
  //     fetchAllAddresses();
  //   } else if (result.hasError) {
  //     AppSnackbar.showError(
  //         context: context,
  //         message: NetworkException.getErrorMessage(result.error));
  //   }
  // }

  // setDefaultBillingAddress(BuildContext context, String id) async {
  //   showLoadingDialog(context);
  //   final result =
  //       await Get.find<AddressRepository>().setDefaultBillingAddress(id);
  //   hideLoadingDialog(context);
  //   if (result.hasData) {
  //     showToast(result.data);
  //     fetchAllAddresses();
  //   } else if (result.hasError) {
  //     AppSnackbar.showError(
  //         context: context,
  //         message: NetworkException.getErrorMessage(result.error));
  //   }
  // }
}
