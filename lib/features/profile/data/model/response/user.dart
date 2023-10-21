import 'package:yeshelpinghand/features/address/data/model/response/address.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? firstname;
  final String? lastname;
  final String? phoneNumber;
  final String? email;
  final String? profileImage;
  final Address? billingAddress;
  final Address? shippingAddress;

  User({
    this.firstname,
    this.lastname,
    this.phoneNumber,
    this.email,
    this.profileImage,
    this.billingAddress,
    this.shippingAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      phoneNumber: json['phoneno'],
      email: json["email"],
      firstname: json['firstname'],
      lastname: json['lastname'],
      // companyBrn: json['companyBrn'],
      // billingAddress: json['billingAddress'] != null
      //     ? Address.fromJson(json['billingAddress'])
      //     : null,
      // shippingAddress: json['shippingAddress'] != null
      //     ? Address.fromJson(json['shippingAddress'])
      //     : null,
    );
  }

  @override
  List<Object?> get props => [firstname, lastname, email];
}
