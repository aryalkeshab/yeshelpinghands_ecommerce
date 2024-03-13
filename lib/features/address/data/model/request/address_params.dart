class AddressParams {
  String? country;
  String? postalCode;
  String? city;
  String? id;
  String? address;
  String? landmark;

  AddressParams({this.postalCode, this.city, this.address, this.landmark, this.id});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['landmark'] = landmark;
    map['country'] = country;
    map['address'] = address;
    map['postal_code'] = postalCode;
    map['city'] = city;
    map['id'] = id;

    return map;
  }
}
