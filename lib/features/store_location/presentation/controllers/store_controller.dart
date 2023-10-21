import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/store_location/data/model/store_model.dart';
import 'package:yeshelpinghand/features/store_location/domain/repository/store_pickup_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../data/model/pickup_store.dart';

class StorePickupController extends GetxController {
  @override
  void onInit() {
    fetchPickupStoreList();

    super.onInit();
  }

  ApiResponse _pickupStoreResponse = ApiResponse();

  ApiResponse get pickupStoreResponse => _pickupStoreResponse;

  set pickupStoreResponse(ApiResponse response) {
    _pickupStoreResponse = response;
    update();
  }

  fetchPickupStoreList() async {
    pickupStoreResponse =
        await Get.find<StorePickupRepository>().fetchStorePickupList();
    if (pickupStoreResponse.hasData) {
      storePickupList = pickupStoreResponse.data;
    }
  }

  initializeStoreId(int? id) {
    _selectedStoreId = id ?? 2;
    // itemScrollController.scrollTo(
    //     index: storePickupList
    //         .indexOf(storePickupList.firstWhere((element) => element.id == id)),
    //     duration: Duration(milliseconds: 500));
  }

  // final Set<Marker> markers = {};
  // final ItemScrollController itemScrollController = ItemScrollController();
  // final ItemPositionsListener itemPositionsListener =
  //     ItemPositionsListener.create();
  int _selectedStoreId = 2;
  List<PickupStore> storePickupList = [];

  set selectedStoreId(int id) {
    _selectedStoreId = id;
    update();
  }

  int get selectedStoreId => _selectedStoreId;

  // Set<Marker> createMarkers(
  //     BuildContext context, List<PickupStore> storePickupList) {
  //   storePickupList.asMap().forEach((index, element) {
  //     markers.add(Marker(
  //       markerId: MarkerId(element.id.toString()),
  //       position: LatLng(element.latitude ?? 0, element.longitude ?? 0),
  //       infoWindow: InfoWindow(
  //         //popup info
  //         title: '${element.name}',
  //         snippet:
  //             '${element.pickupStoreAddress?.address}, ${element.pickupStoreAddress?.city}',
  //       ),
  //       onTap: () {
  //         selectedStoreId = element.id ?? 2;
  //         // itemScrollController.scrollTo(
  //         //     index: index, duration: Duration(milliseconds: 500));
  //       },
  //     ));
  //   });

  //   return markers;
  // }

  final dummyStoreLocation = [
    Store(
      storeName: 'Pokhara Store',
      latitude: 27.9389,
      longitude: 84.4054,
      description: 'pokhara latitude and longitude',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/6/61/Pokhara-valley-nepal.jpg',
    ),
    Store(
      storeName: 'Kathmandu Store',
      latitude: 27.7029,
      longitude: 85.3182,
      description: 'kathmandu longitude and latitude',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/8/89/Locus3.jpg',
    ),
  ];
}
