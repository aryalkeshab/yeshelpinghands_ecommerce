// import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
// import 'package:yeshelpinghand/core/presentation/widgets/buttons.dart';
// import 'package:yeshelpinghand/features/shared/layouts/error_view.dart';
// import 'package:yeshelpinghand/features/store_location/data/model/pickup_store.dart';
// import 'package:yeshelpinghand/features/store_location/presentation/controllers/store_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// class StorePickupMap extends StatefulWidget {
//   final PickupStore? pickupStore;

//   const StorePickupMap({Key? key, this.pickupStore}) : super(key: key);

//   @override
//   State<StorePickupMap> createState() => _StorePickupMapState();
// }

// class _StorePickupMapState extends State<StorePickupMap> {
//   GoogleMapController? mapController;

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) =>
//         Get.find<StorePickupController>()
//             .initializeStoreId(widget.pickupStore?.id));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(widget.pickupStore?.latitude);
//     return BaseWidget(builder: (context, config, theme) {
//       return Scaffold(
//         body: GetBuilder<StorePickupController>(builder: (controller) {
//           final result = controller.pickupStoreResponse;
//           if (result.hasData) {
//             final storePickupList = result.data;
//             return GoogleMap(
//               onMapCreated: (controller) {
//                 mapController = controller;
//               },
//               initialCameraPosition: CameraPosition(
//                 target: widget.pickupStore != null
//                     ? LatLng(widget.pickupStore?.latitude ?? 0,
//                         widget.pickupStore?.longitude ?? 0)
//                     : const LatLng(-20.22416, 57.467655),
//                 zoom: 15.0,
//               ),
//               markers: controller.createMarkers(context, storePickupList),
//             );
//           } else if (result.hasError) {
//             return const ErrorView();
//           } else {
//             return const CircularProgressIndicator();
//           }
//         }),
//         // bottomSheet: StorePickupMapBottomSheet(
//         //   onStorePickupSelect: (targetPosition) {
//         //     mapController?.animateCamera(CameraUpdate.newCameraPosition(
//         //         CameraPosition(target: targetPosition, zoom: 15)
//         //         //17 is new zoom level
//         //         ));
//         //   },
//         // ),
//       );
//     });
//   }
// }

// // class StorePickupMapBottomSheet extends StatelessWidget {
// //   final Function(LatLng) onStorePickupSelect;

// //   const StorePickupMapBottomSheet({
// //     Key? key,
// //     required this.onStorePickupSelect,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return BaseWidget(builder: (context, config, theme) {
// //       return GetBuilder<StorePickupController>(builder: (controller) {
// //         final result = controller.pickupStoreResponse;
// //         if (result.hasData) {
// //           final storePickupList = result.data;
// //           return Container(
// //             padding: EdgeInsets.symmetric(
// //                 vertical: config.appVerticalPaddingSmall(),
// //                 horizontal: config.appEdgePadding()),
// //             height: config.appHeight(35),
// //             width: double.maxFinite,
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Text(
// //                       "Select a pickup store",
// //                       style: theme.textTheme.caption?.copyWith(fontSize: 14),
// //                     ),
// //                     PrimaryTextButton(
// //                       label: "Done",
// //                       onPressed: () {
// //                         Get.back(result: controller.selectedStoreId);
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //                 config.verticalSpaceSmall(),
// //                 SizedBox(
// //                   height: config.appHeight(30),
// //                   child: ScrollablePositionedList.builder(
// //                     itemCount: storePickupList.length,
// //                     itemBuilder: (context, index) {
// //                       final pickupStore = storePickupList[index];
// //                       return Column(
// //                         mainAxisSize: MainAxisSize.min,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           InkWell(
// //                             splashColor: theme.primaryColor.withOpacity(0.1),
// //                             onTap: () {
// //                               controller.selectedStoreId = pickupStore.id;
// //                               onStorePickupSelect(LatLng(
// //                                   pickupStore.latitude ?? 0,
// //                                   pickupStore.longitude ?? 0));
// //                             },
// //                             child: Container(
// //                               width: double.maxFinite,
// //                               padding: EdgeInsets.symmetric(
// //                                 horizontal: config.appHorizontalPaddingSmall(),
// //                                 vertical: config.appVerticalPaddingSmall(),
// //                               ),
// //                               decoration: controller.selectedStoreId ==
// //                                       pickupStore.id
// //                                   ? BoxDecoration(
// //                                       border:
// //                                           Border.all(color: theme.primaryColor))
// //                                   : null,
// //                               child: Column(
// //                                 mainAxisSize: MainAxisSize.min,
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   Text("${pickupStore.name}",
// //                                       style: theme.textTheme.bodyText2
// //                                           ?.copyWith(
// //                                               fontWeight: FontWeight.w600)),
// //                                   Text(
// //                                     "${pickupStore.pickupStoreAddress?.address}, ${pickupStore.pickupStoreAddress?.city}",
// //                                     style: theme.textTheme.caption,
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                           const Divider(),
// //                         ],
// //                       );
// //                     },
// //                     itemScrollController: controller.itemScrollController,
// //                     itemPositionsListener: controller.itemPositionsListener,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //         } else if (result.hasError) {
// //           return const ErrorView();
// //         } else {
// //           return const CircularProgressIndicator();
// //         }
// //       });
// //     });
// //   }
// // }
