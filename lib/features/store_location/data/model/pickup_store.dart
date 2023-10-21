import 'package:yeshelpinghand/core/utils/number_parser.dart';

class PickupStore {
  final int? id;
  final String? name;
  final double? latitude;
  final double? longitude;
  final PickupStoreAddress? pickupStoreAddress;

  PickupStore(
      {this.id,
      this.name,
      this.latitude,
      this.longitude,
      this.pickupStoreAddress});

  factory PickupStore.fromJson(Map<String, dynamic> json) {
    return PickupStore(
      id: NumberParser.intFromString(json['id']),
      name: json['name'],
      latitude: NumberParser.doubleFromString(json['latitude']),
      longitude: NumberParser.doubleFromString(json['longitude']),
      pickupStoreAddress: json['addressDetails'] != null
          ? PickupStoreAddress.fromJson(json['addressDetails'])
          : null,
    );
  }
}

class PickupStoreAddress {
  final String? address;
  final String? city;
  final String? phone;

  PickupStoreAddress({this.address, this.city, this.phone});

  factory PickupStoreAddress.fromJson(Map<String, dynamic> json) {
    return PickupStoreAddress(
      address: json['address'],
      city: json['city'],
      phone: json['phone'],
    );
  }
}
