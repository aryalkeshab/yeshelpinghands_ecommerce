import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/features/store_location/data/model/store_model.dart';
import 'package:yeshelpinghand/features/store_location/domain/repository/store_pickup_repository.dart';
import 'package:get/get.dart';
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
    pickupStoreResponse = await Get.find<StorePickupRepository>().fetchStorePickupList();
    if (pickupStoreResponse.hasData) {
      storePickupList = pickupStoreResponse.data;
    }
  }

  initializeStoreId(int? id) {
    _selectedStoreId = id ?? 2;
  }

  int _selectedStoreId = 2;
  List<PickupStore> storePickupList = [];

  set selectedStoreId(int id) {
    _selectedStoreId = id;
    update();
  }

  int get selectedStoreId => _selectedStoreId;

  final dummyStoreLocation = [
    Store(
      storeName: 'Pokhara Store',
      latitude: 27.9389,
      longitude: 84.4054,
      description: 'pokhara latitude and longitude',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/61/Pokhara-valley-nepal.jpg',
    ),
    Store(
      storeName: 'Kathmandu Store',
      latitude: 27.7029,
      longitude: 85.3182,
      description: 'kathmandu longitude and latitude',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/8/89/Locus3.jpg',
    ),
  ];
}
