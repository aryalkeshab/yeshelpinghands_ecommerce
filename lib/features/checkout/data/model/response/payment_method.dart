class PaymentMethod {
  String? label;
  String? value;

  PaymentMethod({this.label, this.value});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(label: json['label'], value: json['value']);
  }
}
