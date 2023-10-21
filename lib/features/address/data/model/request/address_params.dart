class AddressParams {
  String? firstName;
  String? lastName;
  String? countryCode;
  String? postalCode;
  String? city;
  String? phoneNumber;
  String? company;
  String? street;
  String? province;
  String? provinceId;

  AddressParams(
      {this.countryCode,
      this.postalCode,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.street,
      this.city,
      this.company,
      this.province,
      this.provinceId});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['country_code'] = countryCode;
    map['postal_code'] = postalCode;
    map['city'] = city;
    map['telephone'] = phoneNumber;
    map['company'] = company;
    map['street'] = street;
    map['province'] = province;
    map['province_id'] = provinceId;

    return map;
  }
}
