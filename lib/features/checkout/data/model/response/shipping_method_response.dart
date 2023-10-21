class ShippingMethod {
  final String carrierTitle;
  final String code;

  ShippingMethod({required this.carrierTitle, required this.code});

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(carrierTitle: json['carrier_title'], code: json['code']);
  }
}
