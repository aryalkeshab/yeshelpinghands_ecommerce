import 'country.dart';

class DefaultAddresses {
  final Address? shippingAddress;
  final Address? billingAddress;

  DefaultAddresses({this.shippingAddress, this.billingAddress});

  factory DefaultAddresses.fromJson(Map<String, dynamic> json) {
    return DefaultAddresses(
      shippingAddress: json["shippingAddress"] != null
          ? Address.fromJson(json["shippingAddress"])
          : null,
      billingAddress: json["billingAddress"] != null
          ? Address.fromJson(json["billingAddress"])
          : null,
    );
  }
}

class Address {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? phoneNumber;
  final String? street;
  final String? city;
  final Country? country;
  final String? postalCode;
  final String? province;

  Address({
    this.id,
    this.country,
    this.postalCode,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.street,
    this.city,
    this.company,
    this.province,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['entity_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      company: json['company'],
      street: json['street'],
      phoneNumber: json['telephone'],
      city: json['city'],
      postalCode: json['postal_code'],
      email: json['email'],
      country: json['country'] != null
          ? Country.fromJsonForAddress(json['country'])
          : json['country'],
      province: json['province'],
    );
  }
}
