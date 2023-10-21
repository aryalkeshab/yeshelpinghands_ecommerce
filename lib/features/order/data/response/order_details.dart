import 'package:yeshelpinghand/core/utils/number_parser.dart';
import 'package:yeshelpinghand/features/address/data/model/response/address.dart';

class OrderDetails {
  final String? id;
  final String? status;
  final double? amount;
  final String? orderNo;
  final String? date;
  final Address? shippingAddress;
  final Address? billingAddress;
  final OrderInfo? orderInfo;
  final String? paymentMethod;

  final ShippingMethodInfo? shippingMethodInfo;

  OrderDetails({
    this.id,
    this.status,
    this.amount,
    this.orderNo,
    this.shippingMethodInfo,
    this.date,
    this.shippingAddress,
    this.billingAddress,
    this.orderInfo,
    this.paymentMethod,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['order_increment_id'],
      status: json['status'],
      amount: json['amount'],
      orderNo: json['order_increment_id'],
      date: json['created_at'],
      orderInfo: OrderInfo.fromJson(json['order_details']),
      billingAddress: json['billing_address'] != null
          ? Address.fromJson(json['billing_address'])
          : null,
      shippingAddress: Address.fromJson(json['shipping_address']),
      shippingMethodInfo: ShippingMethodInfo.fromJson(json['shipping_method']),
      paymentMethod: json['payment_method'],
    );
  }
}

class ShippingMethodInfo {
  final String? name;

  ShippingMethodInfo({this.name});

  factory ShippingMethodInfo.fromJson(Map<String, dynamic> json) {
    return ShippingMethodInfo(
      name: json['shipping_method_title'],
    );
  }
}

class OrderInfo {
  List<OrderItem>? orderItems;
  int? subTotal;
  int? shippingFee;
  int? memberPoint;
  int? grandTotal;

  OrderInfo(
      {this.orderItems,
      this.subTotal,
      this.shippingFee,
      this.memberPoint,
      this.grandTotal});

  factory OrderInfo.fromJson(Map<String, dynamic> json) {
    return OrderInfo(
      subTotal: NumberParser.intFromDoubleString(json['sub_total']),
      orderItems: json['order_items'] != null
          ? json['order_items']
              .map<OrderItem>((e) => OrderItem.fromJson(e))
              .toList()
          : null,
      grandTotal: NumberParser.intFromDoubleString(json['grand_total']),
      memberPoint: NumberParser.intFromDoubleString(json['member_point']),
      shippingFee: NumberParser.intFromDoubleString(json['shipping']),
    );
  }
}

class OrderItem {
  final String? name;
  final String? sku;
  final int? price;
  final int? quantity;
  final int? subTotal;

  const OrderItem({
    this.quantity,
    this.price,
    this.subTotal,
    this.name,
    this.sku,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json["product_name"],
      sku: json['product_sku'],
      price: json['product_price'],
      quantity: NumberParser.intFromDoubleString(json['product_qty']),
      subTotal: json['product_subTotal'],
    );
  }
}
