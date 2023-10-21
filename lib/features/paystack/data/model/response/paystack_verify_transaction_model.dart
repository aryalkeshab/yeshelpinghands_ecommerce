class PaystackVerifyTransactionModel {
  bool? status;
  String? message;
  TransactionData? data;

  PaystackVerifyTransactionModel({
    this.status,
    this.data,
    this.message,
  });

  factory PaystackVerifyTransactionModel.fromJson(Map<String, dynamic> json) {
    return PaystackVerifyTransactionModel(
      status: json['status'],
      data:
          json['data'] != null ? TransactionData.fromJson(json['data']) : null,
       message: json['message'],
    );
  }
}

class TransactionData {
  int? id;
  String? reference;
  int? amount;

  TransactionAuthorization? authorization;

  String? status;

  /// Can be [Card, Bank Transfer, etc.]
  String? channel;

  String? gatewayResponse;

  TransactionData({
    this.id,
    this.reference,
    this.amount,
    this.channel,
    this.authorization,
    this.status,
    this.gatewayResponse,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      id: json['id'],
      channel: json['channel'],
      reference: json['reference'],
      amount: json['amount'],
      authorization: json['authorization'] != null
          ? TransactionAuthorization.fromJson(json['authorization'])
          : null,
      status: json['status'],
      gatewayResponse: json['gateway_response'],
    );
  }
}

class TransactionAuthorization {
  String? cardNumber;
  String? expiryMonth;
  String? expiryYear;
  String? channel;
  String? cardType;

  TransactionAuthorization(
      {this.cardNumber,
      this.expiryMonth,
      this.expiryYear,
      this.channel,
      this.cardType});

  factory TransactionAuthorization.fromJson(Map<String, dynamic> json) {
    return TransactionAuthorization(
      cardNumber: json['last4'],
      expiryMonth: json['exp_month'],
      expiryYear: json['exp_year'],
      channel: json['channel'],
      cardType: json['card_type'],
    );
  }
}
