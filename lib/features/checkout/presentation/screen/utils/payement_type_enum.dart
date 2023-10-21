enum PaymentType {
  onlineCardPayment,
  juiceByMCB,
  cimFinance,
  bankTransfer,
  cashOnDelivery,
}

extension PaymentTypeExtension on PaymentType {
  String get name {
    switch (this) {
      case PaymentType.onlineCardPayment:
        return "Online Card Payment (Credit or Debit Card)";

      case PaymentType.juiceByMCB:
        return "Juice By MCB";

      case PaymentType.cimFinance:
        return "CIMFinance";

      case PaymentType.bankTransfer:
        return "Bank Transfer Payment";

      case PaymentType.cashOnDelivery:
        return "Card on Delivery";

      default:
        return "Null";
    }
  }
}
