import 'package:yeshelpinghand/core/data/data_source/remote/network_exception.dart';
import 'package:yeshelpinghand/core/presentation/resources/colors.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
import 'package:yeshelpinghand/core/presentation/widgets/focus_node_disabler.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/core/presentation/widgets/snackbar.dart';
import 'package:yeshelpinghand/features/address/presentation/utils/address_book_type_enum.dart';
import 'package:yeshelpinghand/features/checkout/data/model/request/confirm_order_params.dart';
import 'package:yeshelpinghand/features/checkout/data/model/response/shipping_method_response.dart';
import 'package:yeshelpinghand/features/checkout/presentation/controller/shipping_address_controller.dart';
import 'package:yeshelpinghand/features/checkout/presentation/controller/shipping_method_controller.dart';
import 'package:yeshelpinghand/features/checkout/presentation/screen/checkout_stepper.dart';
import 'package:yeshelpinghand/features/checkout/presentation/screen/widgets/checkout_address_information_layout.dart';
import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../address/data/model/response/address.dart';
import '../../../address/presentation/utils/address_type_enum.dart';
import 'utils/customer_type_enum.dart';

class ShippingAddressScreen extends StatefulWidget {
  final ConfirmOrderParams confirmOrderParams;

  ShippingAddressScreen({Key? key, required this.confirmOrderParams})
      : super(key: key);

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  @override
  void initState() {
    super.initState();
  }

  final shippingAddressController = Get.put(ShippingAddressController());

  Future<void> navigateToAddressListPage(
      {AddressType addressType = AddressType.shipping}) async {
    final result = await Get.toNamed(
      Routes.addressList,
      arguments: AddressBookType.selectable,
    );
    if (result != null) {
      final address = result as Address;
      setState(() {
        addressType == AddressType.shipping
            ? widget.confirmOrderParams.shippingAddress = address
            : widget.confirmOrderParams.billingAddress = address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return HookBaseWidget(builder: (context, config, theme) {
      return FocusNodeDisabler(
        child: CheckoutStepper(
          onProceed: () {
            final formKey = Get.find<ShippingAddressController>().shippingKey;
            if (formKey.currentState?.validate() == true) {
              formKey.currentState!.save();
              if (widget.confirmOrderParams.shippingAddress != null &&
                  widget.confirmOrderParams.billingAddress != null) {
                Get.find<ShippingAddressController>().setCheckoutShippingInfo(
                    context, widget.confirmOrderParams);
              } else {
                AppSnackbar.showWarning(
                  context: context,
                  message: "Please add shipping and billing address",
                );
              }
            }
          },
          currentStep: 1,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(top: config.appVerticalPaddingLarge()),
              child: Form(
                key: Get.find<ShippingAddressController>().shippingKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Builder(builder: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GetBuilder<ShippingMethodController>(
                              builder: (controller) {
                            final result = controller.shippingMethodsResponse;
                            if (result.hasData) {
                              final List<ShippingMethod> shippingMethods =
                                  result.data;
                              widget.confirmOrderParams.shippingMethod =
                                  shippingMethods.first.code;

                              return HookBaseWidget(
                                  builder: (context, config, theme) {
                                final selectedShippingMethod = useState(0);
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Shipping Methods",
                                        style: theme.textTheme.bodyText1
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600)),
                                    config.verticalSpaceSmall(),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                          shippingMethods.length, (index) {
                                        final shippingMethod =
                                            shippingMethods[index];
                                        return Padding(
                                          padding: index !=
                                                  CustomerType.values.length - 1
                                              ? EdgeInsets.only(
                                                  bottom: config
                                                      .appVerticalPaddingSmall())
                                              : EdgeInsets.zero,
                                          child: SelectableOption(
                                            name:
                                                "${shippingMethod.carrierTitle}",
                                            value: "${shippingMethod.code}",
                                            isSelected:
                                                selectedShippingMethod.value ==
                                                    index,
                                            onTap: () {
                                              selectedShippingMethod.value =
                                                  index;
                                              widget.confirmOrderParams
                                                      .shippingMethod =
                                                  shippingMethod.code;
                                            },
                                          ),
                                        );
                                      }),
                                    ),
                                    config.verticalSpaceMedium(),
                                    GetBuilder<ShippingAddressController>(
                                        builder: (controller) {
                                      if (controller.isFirstLoad) {
                                        widget.confirmOrderParams
                                                .shippingAddress =
                                            controller.defaultShippingAddress;
                                        widget.confirmOrderParams
                                                .billingAddress =
                                            controller.defaultBillingAddress;
                                        controller.isFirstLoad = false;
                                      }
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          widget.confirmOrderParams
                                                      .shippingAddress !=
                                                  null
                                              ? CheckoutAddressInformationLayout(
                                                  title: "Shipping Address",
                                                  address: widget
                                                      .confirmOrderParams
                                                      .shippingAddress,
                                                  onChooseAnotherPressed:
                                                      navigateToAddressListPage,
                                                )
                                              : Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    config
                                                        .verticalSpaceMedium(),
                                                    const Text(
                                                        "Select shipping address"),
                                                    config.verticalSpaceSmall(),
                                                    PrimaryOutlinedButton(
                                                      width: 150,
                                                      onPressed:
                                                          navigateToAddressListPage,
                                                      title:
                                                          "+ Add Shipping Address",
                                                    ),
                                                  ],
                                                ),
                                          config.verticalSpaceSmall(),
                                          widget.confirmOrderParams
                                                      .billingAddress !=
                                                  null
                                              ? CheckoutAddressInformationLayout(
                                                  title: "Billing Address",
                                                  address: widget
                                                      .confirmOrderParams
                                                      .billingAddress,
                                                  onChooseAnotherPressed: () =>
                                                      navigateToAddressListPage(
                                                          addressType:
                                                              AddressType
                                                                  .billing),
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    config
                                                        .verticalSpaceMedium(),
                                                    const Text(
                                                        "Select billing address"),
                                                    config.verticalSpaceSmall(),
                                                    PrimaryOutlinedButton(
                                                      width: 150,
                                                      onPressed: () =>
                                                          navigateToAddressListPage(
                                                              addressType:
                                                                  AddressType
                                                                      .billing),
                                                      title:
                                                          "+ Add Billing Address",
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      );
                                    })
                                  ],
                                );
                              });
                            } else if (result.hasError) {
                              return ErrorView(
                                  title: NetworkException.getErrorMessage(
                                      result.error));
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  config.verticalSpaceCustom(0.05),
                                  ShimmerWidget.rounded(
                                      width: config.appWidth(40), height: 30),
                                  config.verticalSpaceLarge(),
                                  ShimmerWidget.rounded(
                                      width: config.appWidth(80), height: 50),
                                  config.verticalSpaceMedium(),
                                  ShimmerWidget.rounded(
                                      width: config.appWidth(80), height: 50),
                                ],
                              );
                            }
                          }),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

// class CustomerTypeSelectionView extends StatelessWidget {
//   const CustomerTypeSelectionView({
//     Key? key,
//     required this.onCustomerTypeSelection,
//     required this.onSaved,
//   }) : super(key: key);
//   final Function(CustomerType customerType) onCustomerTypeSelection;
//   final Function(OrganizationInfo) onSaved;
//
//   @override
//   Widget build(BuildContext context) {
//     return HookBaseWidget(builder: (context, config, theme) {
//       final selectedValue = useState(0);
//       final organizationInfo = OrganizationInfo();
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Customer Type",
//               style: theme.textTheme.bodyText1
//                   ?.copyWith(fontWeight: FontWeight.w600)),
//           config.verticalSpaceSmall(),
//           Column(
//             children: List.generate(CustomerType.values.length, (index) {
//               return Padding(
//                 padding: index != CustomerType.values.length - 1
//                     ? EdgeInsets.only(bottom: config.appVerticalPaddingSmall())
//                     : EdgeInsets.zero,
//                 child: SelectableOption(
//                   value: CustomerType.values[index].value,
//                   name: CustomerType.values[index].name,
//                   isSelected: selectedValue.value == index,
//                   onTap: () {
//                     selectedValue.value = index;
//                     onCustomerTypeSelection(
//                         CustomerType.values[selectedValue.value]);
//                   },
//                 ),
//               );
//             }),
//           ),
//           if (CustomerType.values[selectedValue.value] ==
//               CustomerType.organization)
//             Column(
//               children: [
//                 PrimaryFormField(
//                     hintTxt: "Company VAT Number",
//                     validator: (value) => Validator.validateEmpty(value!),
//                     onSaved: (value) {
//                       organizationInfo.companyVatNumber = value;
//                     }),
//                 PrimaryFormField(
//                     hintTxt: "Company BRN Number",
//                     validator: (value) => Validator.validateEmpty(value!),
//                     onSaved: (value) {
//                       organizationInfo.companyBrnNumber = value;
//                     }),
//               ],
//             ),
//         ],
//       );
//     });
//   }
// }

class SelectableOption extends StatelessWidget {
  const SelectableOption({
    Key? key,
    required this.name,
    required this.value,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);
  final String name;
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: isSelected ? Border.all(color: theme.primaryColor) : null,
          ),
          padding: EdgeInsets.symmetric(
              vertical: config.appVerticalPaddingSmall(),
              horizontal: config.appHorizontalPaddingSmall()),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: theme.primaryColor,
              ),
              config.horizontalSpaceMedium(),
              Text(name),
            ],
          ),
        ),
      );
    });
  }
}

class PrimaryDatePicker extends StatefulWidget {
  final Function(DateTime?) onSaved;

  const PrimaryDatePicker({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<PrimaryDatePicker> createState() => _PrimaryDatePickerState();
}

class _PrimaryDatePickerState extends State<PrimaryDatePicker> {
  @override
  void initState() {
    dateController = TextEditingController();

    super.initState();
  }

  DateTime? pickedDate;
  late TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: true,
      onTap: () async {
        pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2),
          firstDate: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2),
          lastDate: DateTime(DateTime.now().year + 2),
        );

        setState(() {
          dateController.text = pickedDate != null
              ? DateFormat('MMM, d, y').format(pickedDate!)
              : "";
        });
      },
      onSaved: (newValue) {
        widget.onSaved(pickedDate);
      },
      controller: dateController,
      // validator: (_) {
      //   if (pickedDate != null) {
      //     return null;
      //   }
      //   return "You must pick a date";
      // },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(
              color: textFieldBorderColor ?? Colors.grey,
            ),
          ),
          hintText: "Delivery Date",
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: () {},
          )),
    );
  }
}
