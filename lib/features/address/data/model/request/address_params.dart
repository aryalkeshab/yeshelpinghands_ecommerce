class AddressParams {
  // String? firstName;
  // String? lastName;
  String? country;
  String? postalCode;
  String? city;
  // String? phoneNumber;
  // String? company;
  // String? street;
  // String? province;
  // String? provinceId;
  String? address;
  String? landmark;

  AddressParams({this.postalCode, this.city, this.address, this.landmark});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['landmark'] = landmark;
    map['country'] = country;
    map['address'] = address;
    map['postal_code'] = postalCode;
    map['city'] = city;

    return map;
  }
}
