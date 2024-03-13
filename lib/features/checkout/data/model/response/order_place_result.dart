class OrderPlaceResult {
  final String message;
  final OrderPlaceData? data;

  OrderPlaceResult({required this.message, this.data});

  factory OrderPlaceResult.fromJson(Map<String, dynamic> json) => OrderPlaceResult(
      message: json['message'],
      data: json['data'] != null ? OrderPlaceData.fromJson(json['data']) : null);
}

class OrderPlaceData {
  final String email;
  final int amount;
  final String reference;

  OrderPlaceData({required this.email, required this.amount, required this.reference});

  factory OrderPlaceData.fromJson(Map<String, dynamic> json) {
    return OrderPlaceData(
      email: json['email'],
      amount: json['amount'],
      reference: json['reference'],
    );
  }
}
