class PaymentStatusUpdateParams {
  String? reference;
  bool? status;
  String? message;
  PaymentStatusUpdateData? data;

  PaymentStatusUpdateParams(
      {this.reference, this.status, this.message, this.data});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reference'] = reference;
    map['status'] = status;
    map['message'] = message;
    map['data'] = data?.toJson();
    return map;
  }
}

class PaymentStatusUpdateData {
  int? id;
  String? status;
  String? gatewayResponse;
  PaymentStatusUpdateAuthorization? authorization;

  PaymentStatusUpdateData({
    this.id,
    this.status,
    this.gatewayResponse,
    this.authorization,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['gateway_response'] = gatewayResponse;
    map['authorization'] = authorization?.toJson();
    return map;
  }
}

class PaymentStatusUpdateAuthorization {
  String? last4;
  String? expiryMonth;
  String? expiryYear;
  String? cardType;

  PaymentStatusUpdateAuthorization({
    this.last4,
    this.expiryMonth,
    this.expiryYear,
    this.cardType,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['last4'] = last4;
    map['exp_month'] = expiryMonth;
    map['exp_year'] = expiryYear;
    map['card_type'] = cardType;
    return map;
  }
}
