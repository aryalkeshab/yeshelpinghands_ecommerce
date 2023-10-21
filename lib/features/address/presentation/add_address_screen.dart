import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/widgets/focus_node_disabler.dart';
import 'package:yeshelpinghand/core/utils/custom_validators.dart';
import 'package:yeshelpinghand/features/address/data/model/request/address_params.dart';
import 'package:yeshelpinghand/features/address/data/model/response/country.dart';
import 'package:yeshelpinghand/features/address/data/model/response/country_region.dart';
import 'package:yeshelpinghand/features/address/presentation/controller/address_controller.dart';
import 'package:yeshelpinghand/features/address/presentation/controller/country_fetch_controller.dart';
import 'package:yeshelpinghand/features/address/presentation/utils/address_form_type_enum.dart';
import 'package:yeshelpinghand/features/address/presentation/utils/address_type_enum.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';

import '../../../core/presentation/widgets/base_widget.dart';
import '../../../core/presentation/widgets/buttons.dart';
import '../../../core/presentation/widgets/textfields.dart';
import '../data/model/response/address.dart';
import 'controller/state_region_fetch_controller.dart';

class AddressFormParams {
  AddressFormType addressFormType;
  Address? address;
  AddressType addressType;

  AddressFormParams(
      {this.addressType = AddressType.others,
      this.addressFormType = AddressFormType.create,
      this.address});
}

class AddAddressScreen extends StatefulWidget {
  final AddressFormParams addressFormParams;

  AddAddressScreen({
    required this.addressFormParams,
    Key? key,
  }) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  void initState() {
    if (widget.addressFormParams.addressFormType == AddressFormType.edit) {
      Get.put(RegionFetchController()).getRegionByCountryId(
          "${widget.addressFormParams.address?.country?.code}");
    }
    super.initState();
  }

  final AddressParams addressParams = AddressParams();

  final controller = RegionFetchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.addressFormParams.addressFormType == AddressFormType.create
                ? 'Add Address'
                : "Edit Address"),
      ),
      body: FocusNodeDisabler(
        child: SingleChildScrollView(
          child: HookBaseWidget(builder: (context, config, theme) {
            final addAddressFormKey = useMemoized(GlobalKey<FormState>.new);
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: config.appEdgePadding(),
                  vertical: config.appVerticalPaddingLarge()),
              child: Form(
                key: addAddressFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryFormField(
                      initialValue: widget.addressFormParams.address?.firstName,
                      validator: (value) => Validator.validateEmpty(value!),
                      onSaved: (value) {
                        addressParams.firstName = value;
                      },
                      label: "First Name",
                      isRequired: true,
                    ),
                    config.verticalSpaceMedium(),
                    PrimaryFormField(
                      initialValue: widget.addressFormParams.address?.lastName,
                      validator: (value) => Validator.validateEmpty(value!),
                      onSaved: (value) {
                        addressParams.lastName = value;
                      },
                      label: "Last Name",
                      isRequired: true,
                    ),
                    config.verticalSpaceMedium(),
                    PrimaryFormField(
                      initialValue:
                          widget.addressFormParams.address?.phoneNumber,
                      isRequired: true,
                      keyboardType: TextInputType.phone,
                      validator: (value) => Validator.validateNumber(value!),
                      onSaved: (value) {
                        addressParams.phoneNumber = value;
                      },
                      label: "Phone Number",
                    ),
                    config.verticalSpaceMedium(),
                    PrimaryFormField(
                      initialValue: widget.addressFormParams.address?.company,
                      onSaved: (value) {
                        addressParams.company = value;
                      },
                      label: "Company",
                    ),
                    config.verticalSpaceMedium(),
                    PrimaryFormField(
                      initialValue: widget.addressFormParams.address?.street,
                      validator: (value) => Validator.validateEmpty(value!),
                      onSaved: (value) {
                        addressParams.street = value;
                      },
                      label: "Street Address",
                      isRequired: true,
                    ),
                    config.verticalSpaceMedium(),
                    PrimaryFormField(
                      initialValue: widget.addressFormParams.address?.city,
                      isRequired: true,
                      validator: (value) => Validator.validateEmpty(value!),
                      onSaved: (value) {
                        addressParams.city = value;
                      },
                      label: "City",
                    ),
                    config.verticalSpaceMedium(),
                    GetBuilder<CountryFetchController>(
                        init: CountryFetchController(),
                        builder: (controller) {
                          final result = controller.countryListResponse;
                          if (result.hasData) {
                            final List<Country> countryList = result.data;
                            return PrimaryDropDownFormField<Country>(
                              key: UniqueKey(),
                              label: "Country",
                              isRequired: true,
                              items: countryList,
                              itemToString: (value) {
                                return "${value.name}";
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                              value: countryList.firstWhereOrNull((element) =>
                                  element.code ==
                                  widget.addressFormParams.address?.country
                                      ?.code),
                              onChanged: (value) {
                                addressParams.countryCode = value?.code;

                                Get.find<RegionFetchController>()
                                    .getRegionByCountryId(
                                        "${addressParams.countryCode}");
                              },
                            );
                          } else if (result.hasError) {
                            return ErrorView(
                                title: NetworkException.getErrorMessage(
                                    result.error));
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                    config.verticalSpaceMedium(),
                    GetBuilder<RegionFetchController>(
                        init: RegionFetchController(),
                        builder: (controller) {
                          final countryRegionList =
                              controller.countryRegionList;
                          return countryRegionList.isNotEmpty
                              ? PrimaryDropDownFormField<CountryRegion>(
                                  key: UniqueKey(),
                                  label: "State/Province",
                                  isRequired: true,
                                  items: countryRegionList,
                                  itemToString: (value) {
                                    return "${value.name}";
                                  },
                                  onChanged: (value) {
                                    addressParams
                                      ..provinceId = value?.code
                                      ..province = value?.name;
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                  value: countryRegionList.firstWhereOrNull(
                                      (element) =>
                                          element.name ==
                                          widget.addressFormParams.address
                                              ?.province),
                                )
                              : PrimaryFormField(
                                  initialValue: widget
                                      .addressFormParams.address?.province,
                                  isRequired: true,
                                  validator: Validator.validateEmpty,
                                  onSaved: (value) {
                                    addressParams.province = value;
                                  },
                                  label: "State/Province",
                                );
                        }),
                    config.verticalSpaceMedium(),
                    PrimaryFormField(
                      initialValue:
                          widget.addressFormParams.address?.postalCode,
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      validator: (value) => Validator.validateNumber(value!),
                      onSaved: (value) {
                        addressParams.postalCode = value;
                      },
                      label: "Zip/Postal Code",
                    ),
                    config.verticalSpaceLarge(),
                    PrimaryButton(
                      onPressed: () {
                        if (addAddressFormKey.currentState?.validate() ==
                            true) {
                          addAddressFormKey.currentState?.save();
                          if (widget.addressFormParams.addressFormType ==
                              AddressFormType.create) {
                            Get.find<AddressController>()
                                .addAddress(context, addressParams);
                          } else {
                            switch (widget.addressFormParams.addressType) {
                              case AddressType.shipping:
                                Get.find<AddressController>()
                                    .updateDefaultShippingAddress(
                                        context,
                                        "${widget.addressFormParams.address?.id}",
                                        addressParams);
                                break;
                              case AddressType.billing:
                                Get.find<AddressController>()
                                    .updateDefaultBillingAddress(
                                        context,
                                        "${widget.addressFormParams.address?.id}",
                                        addressParams);
                                break;

                              default:
                                Get.find<AddressController>()
                                    .updateNonDefaultAddress(
                                        context,
                                        "${widget.addressFormParams.address?.id}",
                                        addressParams);
                            }
                          }
                        }
                      },
                      label: widget.addressFormParams.addressFormType ==
                              AddressFormType.create
                          ? "Add Address"
                          : "Save Changes",
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
