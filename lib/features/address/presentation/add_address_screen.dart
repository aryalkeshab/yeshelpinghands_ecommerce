import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/core/presentation/widgets/focus_node_disabler.dart';
import 'package:yeshelpinghand/core/utils/custom_validators.dart';
import 'package:yeshelpinghand/features/address/data/model/request/address_params.dart';
import 'package:yeshelpinghand/features/address/presentation/controller/address_controller.dart';
import 'package:yeshelpinghand/features/address/presentation/utils/address_form_type_enum.dart';
import 'package:yeshelpinghand/features/address/presentation/utils/address_type_enum.dart';
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
    super.initState();
  }

  final AddressParams addressParams = AddressParams();

  final controller = RegionFetchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.addressFormParams.addressFormType == AddressFormType.create
            ? 'Add Address'
            : "Edit Address"),
      ),
      body: FocusNodeDisabler(
        child: SingleChildScrollView(
          child: HookBaseWidget(builder: (context, config, theme) {
            final addAddressFormKey = useMemoized(GlobalKey<FormState>.new);
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: config.appEdgePadding(), vertical: config.appVerticalPaddingLarge()),
              child: Form(
                key: addAddressFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryFormField(
                      initialValue: widget.addressFormParams.address?.country,
                      validator: (value) => Validator.validateEmpty(value!),
                      onSaved: (value) {
                        addressParams.country = value;
                      },
                      label: "Country",
                      isRequired: true,
                    ),
                    config.verticalSpaceMedium(),
                    PrimaryFormField(
                      initialValue: widget.addressFormParams.address?.city,
                      validator: (value) => Validator.validateEmpty(value!),
                      onSaved: (value) {
                        addressParams.city = value;
                      },
                      label: "City",
                      isRequired: true,
                    ),
                    config.verticalSpaceMedium(),
                    PrimaryFormField(
                      initialValue: widget.addressFormParams.address?.address,
                      validator: (value) => Validator.validateEmpty(value!),
                      onSaved: (value) {
                        addressParams.address = value;
                      },
                      label: "Address",
                      isRequired: true,
                    ),
                    config.verticalSpaceMedium(),
                    PrimaryFormField(
                      initialValue: widget.addressFormParams.address?.postalCode,
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      validator: (value) => Validator.validateNumber(value!),
                      onSaved: (value) {
                        addressParams.postalCode = value;
                      },
                      label: "Zip/Postal Code",
                    ),
                    config.verticalSpaceMedium(),
                    PrimaryFormField(
                      initialValue: widget.addressFormParams.address?.postalCode,
                      isRequired: true,
                      keyboardType: TextInputType.text,
                      validator: (value) => Validator.validateEmpty(value),
                      onSaved: (value) {
                        addressParams.landmark = value;
                      },
                      label: "Landmark",
                    ),
                    config.verticalSpaceLarge(),
                    PrimaryButton(
                      onPressed: () {
                        if (addAddressFormKey.currentState?.validate() == true) {
                          addAddressFormKey.currentState?.save();
                          if (widget.addressFormParams.addressFormType == AddressFormType.create) {
                            Get.find<AddressController>().addAddress(context, addressParams);
                          } else {
                            switch (widget.addressFormParams.addressType) {
                              case AddressType.shipping:
                                Get.find<AddressController>().updateNonDefaultAddress(context,
                                    "${widget.addressFormParams.address?.id}", addressParams);
                                break;

                              default:
                                Get.find<AddressController>().updateNonDefaultAddress(context,
                                    "${widget.addressFormParams.address?.id}", addressParams);
                            }
                          }
                        }
                      },
                      label: widget.addressFormParams.addressFormType == AddressFormType.create
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
