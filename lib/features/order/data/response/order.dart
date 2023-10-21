import '../../../../core/utils/number_parser.dart';

class Order {
  String? id;
  String? status;
  int? amount;
  String? orderNo;
  String? date;
  String? deliverTo;
  String? orderIncrementalId;

  Order(
      {this.id,
      this.status,
      this.amount,
      this.orderNo,
      this.date,
      this.deliverTo,
      this.orderIncrementalId});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['order_id'],
      status: json['status'],
      amount: NumberParser.intFromDoubleString(json['grand_total']),
      orderNo: json['order_id'],
      date: json['created_at'],
      deliverTo: json['shipping_name'],
      orderIncrementalId: json['order_incremental_id'],
    );
  }
}
