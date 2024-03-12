import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/shimmer_widget.dart';
import 'package:yeshelpinghand/features/address/presentation/add_address_screen.dart';
import 'package:yeshelpinghand/features/address/presentation/controller/address_controller.dart';
import 'package:yeshelpinghand/features/address/presentation/utils/address_book_type_enum.dart';
import 'package:yeshelpinghand/features/address/presentation/utils/address_form_type_enum.dart';
import 'package:yeshelpinghand/features/address/presentation/utils/address_type_enum.dart';
import 'package:yeshelpinghand/features/address/presentation/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import '../../../core/presentation/widgets/base_widget.dart';
import '../data/model/response/address.dart';
import 'widgets/warning_message.dart';

class AddressListScreen extends StatelessWidget {
  final AddressBookType addressBookType;

  const AddressListScreen({
    Key? key,
    this.addressBookType = AddressBookType.selectable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HookBaseWidget(
      builder: (context, config, theme) {
        final selectedAddressId = useState("0");

        return Scaffold(
          appBar: AppBar(title: const Text("Address Book")),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: config.appEdgePadding(), vertical: config.appVerticalPaddingLarge()),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<AddressController>(builder: (controller) {
                    final result = controller.addressResponse;
                    if (result.hasData) {
                      final List<Address> defaultAddresses = result.data;
                      return defaultAddresses.length == 0
                          ? Center(
                              child: const WarningMessage("You have not added any address"),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: defaultAddresses.length,
                              itemBuilder: (context, index) {
                                final address = defaultAddresses[index];
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.addAddress,
                                        arguments: AddressFormParams(
                                            addressType: AddressType.shipping,
                                            addressFormType: AddressFormType.edit,
                                            address: address));
                                  },
                                  child: AddressCard(
                                    // addressType: AddressType.shipping,
                                    address: address,
                                    // isSelectable: addressBookType ==
                                    //     AddressBookType.selectable,
                                    onPressed: (selectedAddress) {
                                      selectedAddressId.value = "${selectedAddress.id}";
                                      Get.back(result: selectedAddress);
                                    },
                                  ),
                                );
                              },
                            );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  // GetBuilder<AddressController>(
                  //     init: AddressController(),
                  //     builder: (controller) {
                  //       final result = controller.addressResponse;
                  //       return Align(
                  //         alignment: Alignment.topLeft,
                  //         child: Builder(builder: (context) {
                  //           if (result.hasError) {
                  //             return const Center(
                  //                 child: ErrorView(
                  //               title: "Some Error occurred",
                  //             ));
                  //           } else if (result.hasData) {
                  //             final List<Address> addressList = result.data;
                  //             if (addressList.isNotEmpty) {
                  //               return Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 children: [
                  //                   if (addressBookType ==
                  //                       AddressBookType.selectable)
                  //                     Text(
                  //                       "Select your address from the list below",
                  //                       style: theme.textTheme.bodyText1
                  //                           ?.copyWith(color: Colors.grey),
                  //                     ),
                  //                   config.verticalSpaceMedium(),
                  //                   Column(
                  //                       mainAxisSize: MainAxisSize.min,
                  //                       children: List.generate(
                  //                         addressList.length,
                  //                         (index) {
                  //                           final shippingAddress =
                  //                               addressList[index];
                  //                           return Column(
                  //                             mainAxisSize: MainAxisSize.min,
                  //                             children: [
                  //                               AddressCard(
                  //                                 isSelectable:
                  //                                     addressBookType ==
                  //                                         AddressBookType
                  //                                             .selectable,
                  //                                 isSelected:
                  //                                     selectedAddressId.value ==
                  //                                         shippingAddress.id,
                  //                                 onPressed: (selectedAddress) {
                  //                                   selectedAddressId.value =
                  //                                       "${selectedAddress.id}";
                  //                                   Get.back(
                  //                                       result:
                  //                                           selectedAddress);
                  //                                 },
                  //                                 address: shippingAddress,
                  //                               ),
                  //                               config.verticalSpaceSmall(),
                  //                             ],
                  //                           );
                  //                         },
                  //                       )),
                  //                 ],
                  //               );
                  //             } else {
                  //               return SizedBox(
                  //                 width: double.maxFinite,
                  //                 child: Column(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     Icon(CupertinoIcons.book,
                  //                         size: 80, color: theme.primaryColor),
                  //                     config.verticalSpaceMedium(),
                  //                     Text("Your address book is empty",
                  //                         style: theme.textTheme.bodyText1
                  //                             ?.copyWith(
                  //                                 fontWeight: FontWeight.w600)),
                  //                   ],
                  //                 ),
                  //               );
                  //             }
                  //           } else {
                  //             return const _LoadingAddressList();
                  //           }
                  //         }),
                  //       );
                  //     }),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: theme.primaryColor,
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Get.toNamed(Routes.addAddress, arguments: AddressFormParams());
            },
          ),
        );
      },
    );
  }
}

class _LoadingAddressList extends StatelessWidget {
  const _LoadingAddressList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(2, (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: config.appVerticalPaddingMedium(),
                    vertical: config.appVerticalPaddingMedium()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShimmerWidget.rounded(width: config.appWidth(35), height: 15, borderRadius: 3),
                    config.verticalSpaceSmall(),
                    ShimmerWidget.rounded(width: config.appWidth(65), height: 15, borderRadius: 3),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ShimmerWidget.circular(radius: 12),
                  config.horizontalSpaceLarge(),
                  ShimmerWidget.circular(radius: 12),
                ],
              ),
            ],
          );
        }),
      );
    });
  }
}
